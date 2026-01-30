//
//  LoadingButton.swift
//  Composing
//
//  Created by Michael Tibollo on 2026-01-15.
//

import SwiftUI
import Navigation
import Theme

/// `LoadingButton` is designed to handle loading states for asynchronous work and chain navigations with a data fetch.
public struct LoadingButton<ViewData>: View {
    
    @State private var isLoading: Bool
    
    let title: String
    let iconName: String?
    let variant: ButtonVariant
    
    private var fetchData: () async throws -> ViewData?
    private var action: ((ViewData) -> Void)?

    public init(
        title: String,
        iconName: String? = nil,
        variant: ButtonVariant = .primary,
        fetchData: @escaping () async throws -> ViewData?,
        action: @escaping (ViewData) -> Void,
    ) where ViewData: Equatable {
        self._isLoading = .init(initialValue: false)
        self.title = title
        self.iconName = iconName
        self.variant = variant
        self.fetchData = fetchData
        self.action = action
    }
    
    public init(
        title: String,
        iconName: String? = nil,
        variant: ButtonVariant = .primary,
        fetchData: @escaping () async throws -> Void
    ) where ViewData == Void {
        self._isLoading = .init(initialValue: false)
        self.title = title
        self.iconName = iconName
        self.variant = variant
        self.fetchData = fetchData
        self.action = nil
    }
    
    public var body: some View {
        ButtonBody(
            variant: variant,
            title: title,
            isLoading: isLoading,
            iconName: iconName
        ) {
            Task { await performFetchData() }
        }
    }
    
    private func performFetchData() async {
        withAnimation { isLoading = true }
        
        do {
            if let data = try await fetchData() {
                action?(data)
            }
        } catch {
            print("Error on load: \(error.localizedDescription)")
        }
        
        withAnimation { isLoading = false }
    }
}

