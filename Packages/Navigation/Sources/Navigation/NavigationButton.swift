//
//  NavigationButton.swift
//  Navigation
//
//  Created by Michael Tibollo on 2026-01-26.
//

import SwiftUI

public struct NavigationButton<Content: View>: View {

    @Environment(Router.self) private var router
    @ViewBuilder var content: () -> Content
    let destination: Destination

    public init(
        destination: Destination,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.destination = destination
        self.content = content
    }

    public init(
        push destination: PushDestination,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.destination = .push(destination)
        self.content = content
    }

    public init(
        sheet destination: SheetDestination,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.destination = .sheet(destination)
        self.content = content
    }

    public init(
        fullScreen destination: FullScreenDestination,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.destination = .fullScreen(destination)
        self.content = content
    }

    public var body: some View {
        Button(action: { router.navigate(to: destination) }) {
            content()
        }
    }
}
