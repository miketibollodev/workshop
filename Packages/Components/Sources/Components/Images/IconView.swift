//
//  IconView.swift
//  Components
//
//  Created by Michael Tibollo on 2026-01-25.
//

import SwiftUI

public struct IconView: View {
    internal enum IconSize {
        case small, medium, large
        
        var size: CGSize {
            switch self {
            case .small: CGSize(width: 12.0, height: 12.0)
            case .medium: CGSize(width: 16.0, height: 16.0)
            case .large: CGSize(width: 24.0, height: 24.0)
            }
        }
    }
    
    var icon: ImageResource
    var size: IconSize
    
    public var body: some View {
        Image(icon)
            .resizable()
            .scaledToFit()
            .frame(size.size)
    }
}
