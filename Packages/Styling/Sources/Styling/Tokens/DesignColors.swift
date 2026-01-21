//
//  DesignColors.swift
//  Styling
//
//  Created by Michael Tibollo on 2026-01-21.
//

import SwiftUI

public struct DesignColors: Sendable {
    public let surface: DesignColorsSurface
    public let text: DesignTextColors
    public let border: DesignBorderColors
    
    public struct DesignColorsSurface: Sendable {
        public let primary: Color
        public let secondary: Color
        public let tertiary: Color
        public let inverse: Color
        public let brand: Color
        public let brandSecondary: Color
        public let brandTertiary: Color
        public let danger: Color
        public let dangerSecondary: Color
        public let dangerTertiary: Color
        public let accent: Color
        public let accentSecondary: Color
        public let accentTertiary: Color
    }
    
    public struct DesignTextColors: Sendable {
        public let primary: Color
        public let secondary: Color
        public let tertiary: Color
        public let inverse: Color
        public let danger: Color
        public let brand: Color
        public let accent: Color
    }
    
    public struct DesignBorderColors: Sendable {
        public let primary: Color
        public let secondary: Color
        public let tertiary: Color
        public let inverse: Color
        public let danger: Color
        public let brand: Color
        public let accent: Color
    }
}

public extension DesignColors {
    static let `default`: DesignColors = .init(
        surface: .init(
            primary: Color("Grey50", bundle: .module),
            secondary: Color("Grey100", bundle: .module),
            tertiary: Color("Grey500", bundle: .module),
            inverse: Color("Grey000", bundle: .module),
            brand: Color("Jade", bundle: .module),
            brandSecondary: Color("Forest", bundle: .module),
            brandTertiary: Color("Lost", bundle: .module),
            danger: Color("Cherry", bundle: .module),
            dangerSecondary: Color("Wine", bundle: .module),
            dangerTertiary: Color("Rouge", bundle: .module),
            accent: Color("Rouge", bundle: .module),
            accentSecondary: Color("Rouge", bundle: .module),
            accentTertiary: Color("Rouge", bundle: .module)
        ),
        text: .init(
            primary: Color("Grey900", bundle: .module),
            secondary: Color("Grey500", bundle: .module),
            tertiary: Color("Grey300", bundle: .module),
            inverse: Color("Grey50", bundle: .module),
            danger: Color("Cherry", bundle: .module),
            brand: Color("Jade", bundle: .module),
            accent: Color("Rouge", bundle: .module)
        ),
        border: .init(
            primary: Color("Grey300", bundle: .module),
            secondary: Color("Grey500", bundle: .module),
            tertiary: Color("Forest", bundle: .module),
            inverse: Color("Grey50", bundle: .module),
            danger: Color("Cherry", bundle: .module),
            brand: Color("Jade", bundle: .module),
            accent: Color("Rouge", bundle: .module)
        )
    )
}
