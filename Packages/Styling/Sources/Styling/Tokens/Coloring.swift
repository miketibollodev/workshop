//
//  Coloring.swift
//  Styling
//
//  Created by Michael Tibollo on 2026-01-15.
//

import SwiftUI

public struct Coloring {
    nonisolated(unsafe) public static let brand = Brand()
    nonisolated(unsafe) public static let surface = Surface()
    nonisolated(unsafe) public static let text = Text()

    public init() {}
}

public struct Brand {
    public let primary = Color("BrandPrimary", bundle: .module)
    public let secondary = Color("BrandSecondary", bundle: .module)
}

public struct Surface {
    public let primary = Color("SurfacePrimary", bundle: .module)
    public let secondary = Color("SurfaceSecondary", bundle: .module)
}

public struct Text {
    public let primary = Color("TextPrimary", bundle: .module)
    public let secondary = Color("TextSecondary", bundle: .module)
    public let tertiary = Color("TextTertiary", bundle: .module)
}
