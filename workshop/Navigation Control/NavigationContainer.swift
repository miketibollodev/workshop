//
//  NavigationController.swift
//  workshop
//
//  Created by Michael Tibollo on 2026-01-26.
//

import SwiftUI
import Navigation

struct NavigationContainer<Content: View>: View {
    
    @State var router: Router
    @ViewBuilder var content: () -> Content
    
    init(
        parentRouter: Router,
        tab: TabDestination? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._router = .init(initialValue: parentRouter.childRouter(for: tab))
        self.content = content
    }
    
    var body: some View {
        InnerContainer(router: router) {
            content()
        }
        .environment(router)
        .onAppear(perform: router.setActive)
        .onDisappear(perform: router.resignActive)
    }
}

private struct InnerContainer<Content: View>: View {
    
    @Bindable var router: Router
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        NavigationStack(path: $router.navigationStackPath) {
            content()
                .navigationDestination(for: PushDestination.self) { destination in
                    view(for: destination)
                }
        }
        .sheet(item: $router.presentingSheet) { sheet in
            navigationView(sheet: sheet, from: router)
        }
        .fullScreenCover(item: $router.presentingFullScreen) { fullScreen in
            navigationView(fullScreen: fullScreen, from: router)
        }
    }
    
    @ViewBuilder func navigationView(sheet destination: SheetDestination, from router: Router) -> some View {
        NavigationContainer(parentRouter: router) { view(for: destination) }
    }

    @ViewBuilder func navigationView(fullScreen destination: FullScreenDestination, from router: Router) -> some View {
        NavigationContainer(parentRouter: router) { view(for: destination) }
    }
}
