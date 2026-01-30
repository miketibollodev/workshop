//
//  LoadingButtonStyle.swift
//  Composing
//
//  Created by Michael Tibollo on 2026-01-15.
//

import SwiftUI
import Theme

public enum ButtonVariant: CaseIterable, Identifiable {
    public var id: Self { self }

    case primary
    case secondary
    case tertiary
    case destructive
}

internal struct ButtonBody: View {
    
    @Environment(\.hapticProvider) private var haptics
    @Environment(\.tokens) private var tokens
    
    var variant: ButtonVariant
    var title: String
    var isLoading: Bool = false
    var iconName: String?
    var action: (() -> Void)?
    
    var body: some View {
        Button {
            haptics.provide(.impact(.light))
            action?()
        } label: {
            ZStack {
                ProgressView()
                    .opacity(isLoading ? 1 : 0)
                
                HStack(alignment: .center, spacing: tokens.space.space2) {
                    Text(title)
                        .font(tokens.typography.label.large)
                    
                    if let iconName {
                        Image(systemName: iconName)
                            .resizable()
                            .frame(
                                width: tokens.space.space4,
                                height: tokens.space.space4
                            )
                    }
                }
                .opacity(isLoading ? 0 : 1)
            }
        }
        .buttonStyle(LoadingButtonStyle(variant: variant))
        .disabled(isLoading)
        .accessibilityLabel(title)
        .accessibilityHint(isLoading ? "Loading" : "Button")
        .accessibilityAddTraits(.isButton)
    }
}

internal struct LoadingButtonStyle: ButtonStyle {
        
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.tokens) private var tokens
    
    let variant: ButtonVariant
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(textColor)
            .padding(.horizontal, tokens.space.space4)
            .padding(.vertical, tokens.space.space4)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(backgroundColor(configuration.isPressed))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
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
        case .primary: tokens.color.text.inverse
        case .secondary: tokens.color.text.brand
        case .tertiary: tokens.color.text.brand
        case .destructive: tokens.color.text.inverse
        }
    }
    
    private var backgroundColorDefault: Color {
        switch variant {
        case .primary: tokens.color.surface.brand
        case .secondary: tokens.color.surface.secondary
        case .tertiary: tokens.color.surface.primary
        case .destructive: tokens.color.surface.danger
        }
    }
    
    private var backgroundColorPressed: Color {
        switch variant {
        case .primary: tokens.color.surface.brandSecondary
        case .secondary: tokens.color.surface.brandTertiary
        case .tertiary: tokens.color.surface.brandTertiary
        case .destructive: tokens.color.surface.dangerSecondary
        }
    }
    
    private var borderColorDefault: Color {
        switch variant {
        case .primary: tokens.color.border.brand
        case .secondary: tokens.color.border.brand
        case .tertiary: .clear
        case .destructive: tokens.color.border.danger
        }
    }
    
    private var borderColorPressed: Color {
        switch variant {
        case .primary: tokens.color.border.brand
        case .secondary: tokens.color.border.brand
        case .tertiary: .clear
        case .destructive: tokens.color.border.danger
        }
    }
}
