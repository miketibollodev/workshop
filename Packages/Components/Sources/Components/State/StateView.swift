//
//  StateView.swift
//  Components
//
//  Created by Michael Tibollo on 2026-01-27.
//

import SwiftUI

public struct StateView<ViewData: Equatable, LoadingContent: View, DataContent: View>: View {
    
    @Binding var state: LoadingState<ViewData>
    @ViewBuilder var loadingContent: () -> LoadingContent
    @ViewBuilder var dataContent: (ViewData) -> DataContent
    var fetchData: () async throws -> ViewData

    public init(
        state: Binding<LoadingState<ViewData>>,
        loadingContent: @escaping () -> LoadingContent,
        dataContent: @escaping (ViewData) -> DataContent,
        fetchData: @escaping () async throws -> ViewData
    ) {
        self._state = state
        self.loadingContent = loadingContent
        self.dataContent = dataContent
        self.fetchData = fetchData
    }

    public var body: some View {
        Group {
            switch state {
            case .idle,
                 .loading:
                loadingContent()
                    .disabled(true)

            case let .dataLoaded(viewData):
                dataContent(viewData)

            case let .error(error):
                ErrorView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task { await initialLoad() }
        .refreshable { await performFetchData(showLoading: false) }
    }

    func initialLoad() async {
        guard state == .idle else { return }
        await performFetchData()
    }

    func retry() {
        Task { await performFetchData() }
    }

    private func performFetchData(showLoading: Bool = true) async {
        if showLoading { withAnimation { state = .loading } }

        do {
            let viewData = try await fetchData()
            withAnimation { state = .dataLoaded(viewData) }
        } catch {
            withAnimation { state = .error(error) }
        }
    }
}

public extension StateView where LoadingContent == LoadingView {
    init(
        state: Binding<LoadingState<ViewData>>,
        dataContent: @escaping (ViewData) -> DataContent,
        fetchData: @escaping () async throws -> ViewData
    ) {
        _state = state
        self.loadingContent = { LoadingView() }
        self.dataContent = dataContent
        self.fetchData = fetchData
    }
}
