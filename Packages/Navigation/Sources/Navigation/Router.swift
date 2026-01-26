//
//  Router.swift
//  Navigation
//
//  Created by Michael Tibollo on 2026-01-26.
//

import Foundation
import Observation

@Observable
public final class Router {
    
    let id = UUID()
    let level: Int
    weak var parent: Router?
    
    public let identifierTab: TabDestination?
    public var selectedTab: TabDestination?
    public var navigationStackPath: [PushDestination] = []
    public var presentingSheet: SheetDestination?
    public var presentingFullScreen: FullScreenDestination?
    
    private(set) var isActive: Bool = false
    
    public init(level: Int, identifierTab: TabDestination?) {
        self.level = level
        self.identifierTab = identifierTab
        self.parent = nil
    }
    
    private func resetContent() {
        navigationStackPath = []
        presentingSheet = nil
        presentingFullScreen = nil
    }
    
    // MARK: - Router Management
    
    public func childRouter(for tab: TabDestination? = nil) -> Router {
        let router = Router(level: level + 1, identifierTab: tab ?? identifierTab)
        router.parent = self
        return router
    }
    
    public func resignActive() {
        isActive = false
        parent?.setActive()
    }
    
    public func setActive() {
        parent?.resignActive()
        isActive = true
    }
    
    // MARK: - Navigation
    
    public func navigate(to destination: Destination) {
        switch destination {
        case let .tab(tab):
            select(tab: tab)
        case let .push(destination):
            push(destination)
        case let .sheet(destination):
            present(sheet: destination)
        case let .fullScreen(destination):
            present(fullScreen: destination)
        }
    }
    
    private func select(tab destination: TabDestination) {
        if level == 0 {
            selectedTab = destination
        } else {
            parent?.select(tab: destination)
            resetContent()
        }
    }
    
    private func push(_ destination: PushDestination) {
        navigationStackPath.append(destination)
    }
    
    private func present(sheet destination: SheetDestination) {
        presentingSheet = destination
    }
    
    private func present(fullScreen destination: FullScreenDestination) {
        presentingFullScreen = destination
    }
    
    // MARK: - Preview
    
    static func previewRouter() -> Router {
        Router(level: 0, identifierTab: nil)
    }
}
