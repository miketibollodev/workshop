//
//  IconView.swift
//  Components
//
//  Created by Michael Tibollo on 2026-01-25.
//

import SwiftUI

public enum IconSize: Identifiable {
    public var id: Self { self }
    
    case small
    case medium
    case large
    
    var size: CGSize {
        switch self {
        case .small: CGSize(width: 12.0, height: 12.0)
        case .medium: CGSize(width: 16.0, height: 16.0)
        case .large: CGSize(width: 24.0, height: 24.0)
        }
    }
}

public struct IconView: View {
    
    var icon: ImageResource
    var iconSize: IconSize
    
    public init(_ icon: ImageResource, iconSize: IconSize) {
        self.icon = icon
        self.iconSize = iconSize
    }
    
    public var body: some View {
        Image(icon)
            .resizable()
            .scaledToFit()
            .frame(iconSize.size)
    }
}
