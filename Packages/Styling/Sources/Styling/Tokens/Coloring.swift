//
//  Coloring.swift
//  Styling
//
//  Created by Michael Tibollo on 2026-01-15.
//

import SwiftUI

/// Color tokens organized by usage: surfaces, text, and borders.
///
/// Colors are loaded from asset catalogs in the module bundle. Access through `Styling.coloring`.
public struct Coloring {
    nonisolated(unsafe) public static let surface = Surface()
    nonisolated(unsafe) public static let text = TextColor()
    nonisolated(unsafe) public static let border = Border()

    public init() {}
}

/// Surface colors for backgrounds and containers.
public struct Surface {
    public let primary = Color("Grey50", bundle: .module)
    public let secondary = Color("Grey100", bundle: .module)
    public let tertiary = Color("Grey500", bundle: .module)
    public let inverse = Color("Grey000", bundle: .module)
    public let brand = Color("Jade", bundle: .module)
    public let brandSecondary = Color("Forest", bundle: .module)
    public let brandTertiary = Color("Lost", bundle: .module)
    public let brandLight = Color("Honeydew", bundle: .module)
    public let danger = Color("Cherry", bundle: .module)
    public let dangerSecondary = Color("Wine", bundle: .module)
    public let dangerTertiary = Color("Rouge", bundle: .module)

}

/// Text colors for different text hierarchy levels and semantic states.
public struct TextColor {
    public let primary = Color("Grey900", bundle: .module)
    public let secondary = Color("Grey500", bundle: .module)
    public let tertiary = Color("Grey300", bundle: .module)
    public let inverse = Color("Grey50", bundle: .module)
    public let danger = Color("Cherry", bundle: .module)
    public let brand = Color("Jade", bundle: .module)
}

/// Border colors for dividers and outlines.
public struct Border {
    public let primary = Color("Grey300", bundle: .module)
    public let secondary = Color("Grey500", bundle: .module)
    public let brand = Color("Jade", bundle: .module)
    public let brandSecondary = Color("Forest", bundle: .module)
    public let brandTertiary = Color("Lost", bundle: .module)
    public let danger = Color("Cherry", bundle: .module)
    public let dangerSecondary = Color("Wine", bundle: .module)
    public let dangerTertiary = Color("Rouge", bundle: .module)
}
