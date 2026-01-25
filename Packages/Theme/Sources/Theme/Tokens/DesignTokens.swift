//
//  DesignTokens.swift
//  Styling
//
//  Created by Michael Tibollo on 2026-01-15.
//

import SwiftUI

extension EnvironmentValues {
    @Entry public var tokens: DesignTokens = .default
}

///
/// To use `DesignTokens` in a `View`:
/// ```
/// struct MyView: View {
///     @Environment(\.tokens) private var tokens
///
///     var body: some View {
///         Text("Styling")
///             .padding(tokens.space.space4)
///             .foregroundStyle(tokens.color.border.accent)
///             .font(tokens.typography.label.medium)
///     }
/// }
/// ```
///
/// To set custom colors, spacing, and typography:
/// ```
/// @main
/// struct MyApp: App {
///     let customTokens = DesignTokens(
///         color: .default,
///         space: .init(base: 4),
///         typography: .default
///     )
///
///     var body: some Scene {
///         WindowGroup {
///             ContentView()
///                 .environment(\.tokens, customTokens)
///         }
///     }
/// }
/// ```
///
public struct DesignTokens: Sendable {
    public let color: DesignColors
    public let space: DesignSpace
    public let typography: DesignTypography
}

public extension DesignTokens {
    static let `default`: DesignTokens = .init(
        color: .default,
        space: .default,
        typography: .default
    )
}
