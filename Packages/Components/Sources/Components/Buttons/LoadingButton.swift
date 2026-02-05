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
    
    @Environment(Router.self) private var router
    @State private var isLoading: Bool
    
    let title: String
    let iconName: String?
    let variant: ButtonVariant
    
    private var destinationBuilder: ((ViewData) -> Destination)?
    private var fetchData: () async throws -> ViewData?
    private var action: ((ViewData) -> Void)?

    public init(
        title: String,
        iconName: String? = nil,
        variant: ButtonVariant = .primary,
        fetchData: @escaping () async throws -> ViewData?,
        destination builder: ((ViewData) -> Destination)? = nil,
        action: ((ViewData) -> Void)? = nil
    ) {
        self._isLoading = .init(initialValue: false)
        self.title = title
        self.iconName = iconName
        self.variant = variant
        self.fetchData = fetchData
        self.destinationBuilder = builder
        self.action = action
    }
    
    public init(
        title: String,
        iconName: String? = nil,
        variant: ButtonVariant = .primary,
        fetchData: @escaping () async throws -> ViewData?
    ) {
        self.init(
            title: title,
            iconName: iconName,
            variant: variant,
            fetchData: fetchData,
            destination: nil,
            action: nil
        )
    }
    
    public init(
        title: String,
        iconName: String? = nil,
        variant: ButtonVariant = .primary,
        fetchData: @escaping () async throws -> ViewData?,
        push builder: @escaping (ViewData) -> PushDestination,
        action: ((ViewData) -> Void)? = nil
    ) {
        self.init(
            title: title,
            iconName: iconName,
            variant: variant,
            fetchData: fetchData,
            destination: { .push(builder($0)) },
            action: action
        )
    }
    
    public init(
        title: String,
        iconName: String? = nil,
        variant: ButtonVariant = .primary,
        fetchData: @escaping () async throws -> ViewData?,
        sheet builder: @escaping (ViewData) -> SheetDestination,
        action: ((ViewData) -> Void)? = nil
    ) {
        self.init(
            title: title,
            iconName: iconName,
            variant: variant,
            fetchData: fetchData,
            destination: { .sheet(builder($0)) },
            action: action
        )
    }
    
    public init(
        title: String,
        iconName: String? = nil,
        variant: ButtonVariant = .primary,
        fetchData: @escaping () async throws -> ViewData?,
        fullScreen builder: @escaping (ViewData) -> FullScreenDestination,
        action: ((ViewData) -> Void)? = nil
    ) {
        self.init(
            title: title,
            iconName: iconName,
            variant: variant,
            fetchData: fetchData,
            destination: { .fullScreen(builder($0)) },
            action: action
        )
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
        
        if let data = try? await fetchData() {
            action?(data)
            
            if let destinationBuilder {
                router.navigate(to: destinationBuilder(data))
            }
        }

        withAnimation { isLoading = false }
    }
}

