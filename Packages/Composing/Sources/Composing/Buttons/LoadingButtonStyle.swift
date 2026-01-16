//
//  LoadingButtonStyle.swift
//  Composing
//
//  Created by Michael Tibollo on 2026-01-15.
//

import SwiftUI
import Styling

public struct LoadingButtonStyle: ButtonStyle {
        
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.styling) private var styling
    
    let variant: ButtonVariant
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(textColor)
            .padding(.horizontal, styling.spacing.space4)
            .padding(.vertical, styling.spacing.space3)
            .background(
                RoundedRectangle(cornerRadius: styling.spacing.radius3)
                    .fill(backgroundColor(configuration.isPressed))
            )
            .overlay(
                RoundedRectangle(cornerRadius: styling.spacing.radius3)
                    .stroke(borderColor(configuration.isPressed), lineWidth: 1)
            )
            .opacity(isEnabled ? 1.0 : 0.5)
            .scaleEffect(configuration.isPressed ? 0.92 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
    
    private func borderColor(_ isPressed: Bool) -> Color {
        return isPressed ? borderColorPressed : borderColorDefault
    }

    private func backgroundColor(_ isPressed: Bool) -> Color {
        return isPressed ? backgroundColorPressed : backgroundColorDefault
    }
    
    private var textColor: Color {
        switch variant {
        case .primary: styling.coloring.text.inverse
        case .secondary: styling.coloring.text.brand
        case .tertiary: styling.coloring.text.brand
        case .destructive: styling.coloring.text.inverse
        }
    }
    
    private var backgroundColorDefault: Color {
        switch variant {
        case .primary: styling.coloring.surface.brand
        case .secondary: styling.coloring.surface.secondary
        case .tertiary: styling.coloring.surface.primary
        case .destructive: styling.coloring.surface.danger
        }
    }
    
    private var backgroundColorPressed: Color {
        switch variant {
        case .primary: styling.coloring.surface.brandSecondary
        case .secondary: styling.coloring.surface.brandLight
        case .tertiary: styling.coloring.surface.brandLight
        case .destructive: styling.coloring.surface.dangerSecondary
        }
    }
    
    private var borderColorDefault: Color {
        switch variant {
        case .primary: styling.coloring.border.brand
        case .secondary: styling.coloring.border.brand
        case .tertiary: .clear
        case .destructive: styling.coloring.border.danger
        }
    }
    
    private var borderColorPressed: Color {
        switch variant {
        case .primary: styling.coloring.border.brandSecondary
        case .secondary: styling.coloring.border.brand
        case .tertiary: .clear
        case .destructive: styling.coloring.border.dangerSecondary
        }
    }
}
