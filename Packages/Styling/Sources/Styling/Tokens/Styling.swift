//
//  Styling.swift
//  Styling
//
//  Created by Michael Tibollo on 2026-01-15.
//

import SwiftUI

public struct Styling : Sendable{
    public let coloring: Coloring.Type = Coloring.self
    public let typing: Typing.Type = Typing.self
    public let spacing: Spacing.Type = Spacing.self
}

private struct StylingKey: EnvironmentKey {
    static let defaultValue: Styling = Styling()
}

public extension EnvironmentValues {
    var styling: Styling {
        get { self[StylingKey.self] }
        set { self[StylingKey.self] = newValue }
    }
}
