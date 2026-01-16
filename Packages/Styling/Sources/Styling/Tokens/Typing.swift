//
//  Typing.swift
//  Styling
//
//  Created by Michael Tibollo on 2026-01-15.
//

import SwiftUI

public struct Typing {
    nonisolated(unsafe) public static let display = Display()
    nonisolated(unsafe) public static let title = Title()
    nonisolated(unsafe) public static let body = Body()
    nonisolated(unsafe) public static let label = LabelFont()
    nonisolated(unsafe) public static let utility = Utility()
}

public struct Display {
    public let large = Font.custom("Poppins-SemiBold", size: 48)
    public let medium = Font.custom("Poppins-SemiBold", size: 36)
    public let small = Font.custom("Poppins-SemiBold", size: 24)
}

public struct Title {
    public let xlarge = Font.custom("Poppins-SemiBold", size: 32)
    public let large = Font.custom("Poppins-SemiBold", size: 24)
    public let medium = Font.custom("Poppins-SemiBold", size: 20)
    public let small = Font.custom("Poppins-SemiBold", size: 18)
}

public struct Body {
    public let large = Font.custom("Poppins-Regular", size: 16)
    public let medium = Font.custom("Poppins-Regular", size: 14)
    public let small = Font.custom("Poppins-Regular", size: 12)
}

public struct LabelFont {
    public let large = Font.custom("Poppins-Medium", size: 16)
    public let medium = Font.custom("Poppins-Medium", size: 14)
    public let small = Font.custom("Poppins-Medium", size: 12)
}

public struct Utility {
    public let caption = Font.custom("Poppins-Regular", size: 12)
}
