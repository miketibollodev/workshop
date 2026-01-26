//
//  Destination.swift
//  Navigation
//
//  Created by Michael Tibollo on 2026-01-26.
//

import Foundation
import Models

public enum Destination: Hashable, CustomStringConvertible {
    case tab(_ destination: TabDestination)
    case push(_ destination: PushDestination)
    
    public var description: String {
        switch self {
        case let .tab(destination): ".tab(\(destination))"
        case let .push(destination): ".push(\(destination))"
        }
    }
}

// MARK: - Tab

public enum TabDestination: String, Hashable {
    case home
    case explore
    case messages
    case profile
}

// MARK: - Push

public enum PushDestination: Hashable, CustomStringConvertible {
    case myPushDestination(model: MyModel)
    
    public var description: String {
        switch self {
        case let .myPushDestination(model): ".myPushDestination(\(model.id))"
        }
    }
}

// MARK: - Sheet

public enum SheetDestination: Hashable, CustomStringConvertible {
    case mySheetDestination(model: MyModel)
    
    public var description: String {
        switch self {
        case let .mySheetDestination(model): ".mySheetDestination(\(model.id))"
        }
    }
}

// MARK: - Full Screen

public enum FullScreenDestination: Hashable, CustomStringConvertible, Identifiable {
    case myFullScreenDestination(model: MyModel)
    
    public var description: String {
        switch self {
        case let .myFullScreenDestination(model): ".myFullScreenDestination(\(model.id))"
        }
    }
    
    public var id: String {
        switch self {
        case let .myFullScreenDestination(model): model.id.uuidString
        }
    }
}
