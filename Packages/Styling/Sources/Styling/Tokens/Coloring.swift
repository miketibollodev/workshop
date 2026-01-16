//
//  Coloring.swift
//  Styling
//
//  Created by Michael Tibollo on 2026-01-15.
//

import SwiftUI

public struct Coloring {
    nonisolated(unsafe) public static let surface = Surface()
    nonisolated(unsafe) public static let text = TextColor()
    nonisolated(unsafe) public static let border = Border()

    public init() {}
}

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

public struct TextColor {
    public let primary = Color("Grey900", bundle: .module)
    public let secondary = Color("Grey500", bundle: .module)
    public let tertiary = Color("Grey300", bundle: .module)
    public let inverse = Color("Grey50", bundle: .module)
    public let danger = Color("Cherry", bundle: .module)
    public let brand = Color("Jade", bundle: .module)
}

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
