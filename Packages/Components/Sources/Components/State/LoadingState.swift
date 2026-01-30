//
//  LoadingState.swift
//  Components
//
//  Created by Michael Tibollo on 2026-01-27.
//

import SwiftUI

public enum LoadingState<Value>: Equatable where Value: Equatable {
    
    case idle
    case loading
    case disabled
    case dataLoaded(_ value: Value)
    case error(_ error: Error)
    
    public var value: Value? {
        guard case let .dataLoaded(value) = self else { return nil }
        return value
    }
    
    public var error: Error? {
        guard case let .error(error) = self else { return nil }
        return error
    }
    
    public static func == (lhs: LoadingState<Value>, rhs: LoadingState<Value>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading):
            true
        case let (.dataLoaded(lhsValue), .dataLoaded(rhsValue)):
            lhsValue == rhsValue
        case let (.error(lhsError), .error(rhsError)):
            (lhsError as NSError) == (rhsError as NSError)
        default:
            false
        }
    }
}
