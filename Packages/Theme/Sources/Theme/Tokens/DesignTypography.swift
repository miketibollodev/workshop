//
//  DesignTypography.swift
//  Styling
//
//  Created by Michael Tibollo on 2026-01-21.
//

import SwiftUI

public struct DesignTypography: Sendable {
    public let display: DesignTypographyDisplay
    public let title: DesignTypographyTitle
    public let body: DesignTypographyBody
    public let label: DesignTypographyLabel
    
    public struct DesignTypographyDisplay: Sendable {
        public let large: Font
        public let medium: Font
        public let small: Font
    }
    
    public struct DesignTypographyTitle: Sendable {
        public let large: Font
        public let medium: Font
        public let small: Font
    }
    
    public struct DesignTypographyBody: Sendable {
        public let large: Font
        public let medium: Font
        public let small: Font
    }
    
    public struct DesignTypographyLabel: Sendable {
        public let large: Font
        public let medium: Font
        public let small: Font
    }
}

public extension DesignTypography {
    static let `default`: DesignTypography = .init(
        display: .init(
            large: Font.custom("Poppins-SemiBold", size: 48),
            medium: Font.custom("Poppins-SemiBold", size: 36),
            small: Font.custom("Poppins-SemiBold", size: 24)
        ),
        title: .init(
            large: Font.custom("Poppins-SemiBold", size: 32),
            medium: Font.custom("Poppins-SemiBold", size: 24),
            small: Font.custom("Poppins-SemiBold", size: 20)
        ),
        body: .init(
            large: Font.custom("Poppins-Regular", size: 16),
            medium: Font.custom("Poppins-Regular", size: 14),
            small: Font.custom("Poppins-Regular", size: 12)
        ),
        label: .init(
            large: Font.custom("Poppins-Medium", size: 16),
            medium: Font.custom("Poppins-Medium", size: 14),
            small: Font.custom("Poppins-Medium", size: 14)
        )
    )
}
