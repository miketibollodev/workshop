//
//  Typing.swift
//  Styling
//
//  Created by Michael Tibollo on 2026-01-15.
//

import SwiftUI

/// Typography tokens organized by text hierarchy: display, title, body, label, and utility.
///
/// Uses the Poppins font family. Access through `Styling.typing`.
public struct Typing {
    nonisolated(unsafe) public static let display = Display()
    nonisolated(unsafe) public static let title = Title()
    nonisolated(unsafe) public static let body = Body()
    nonisolated(unsafe) public static let label = LabelFont()
    nonisolated(unsafe) public static let utility = Utility()
}

/// Display fonts for large headings (SemiBold).
public struct Display {
    public let large = Font.custom("Poppins-SemiBold", size: 48)
    public let medium = Font.custom("Poppins-SemiBold", size: 36)
    public let small = Font.custom("Poppins-SemiBold", size: 24)
}

/// Title fonts for section headings (SemiBold).
public struct Title {
    public let xlarge = Font.custom("Poppins-SemiBold", size: 32)
    public let large = Font.custom("Poppins-SemiBold", size: 24)
    public let medium = Font.custom("Poppins-SemiBold", size: 20)
    public let small = Font.custom("Poppins-SemiBold", size: 18)
}

/// Body fonts for paragraph text (Regular).
public struct Body {
    public let large = Font.custom("Poppins-Regular", size: 16)
    public let medium = Font.custom("Poppins-Regular", size: 14)
    public let small = Font.custom("Poppins-Regular", size: 12)
}

/// Label fonts for UI controls and buttons (Medium).
public struct LabelFont {
    public let large = Font.custom("Poppins-Medium", size: 16)
    public let medium = Font.custom("Poppins-Medium", size: 14)
    public let small = Font.custom("Poppins-Medium", size: 12)
}

/// Utility fonts for captions and metadata (Regular).
public struct Utility {
    public let caption = Font.custom("Poppins-Regular", size: 12)
}
