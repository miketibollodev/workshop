//
//  Styling.swift
//  Styling
//
//  Created by Michael Tibollo on 2026-01-15.
//

import SwiftUI

/// Main styling container that provides access to all design tokens.
///
/// Combines coloring, typing, and spacing tokens. Access through the SwiftUI environment:
/// ```swift
/// @Environment(\.styling) private var styling
///
/// Text("Hello")
///     .font(styling.typing.title.large)
///     .foregroundColor(styling.coloring.text.primary)
///     .padding(styling.spacing.space4)
/// ```
public struct Styling: Sendable {
    public let coloring: Coloring.Type = Coloring.self
    public let typing: Typing.Type = Typing.self
    public let spacing: Spacing.Type = Spacing.self
}

/// Environment key for accessing styling tokens in SwiftUI views.
public extension EnvironmentValues {
    var styling: Styling {
        get { self[StylingKey.self] }
        set { self[StylingKey.self] = newValue }
    }
}

private struct StylingKey: EnvironmentKey {
    static let defaultValue: Styling = Styling()
}
