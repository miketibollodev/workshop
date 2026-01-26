//
//  LoadingButton.swift
//  Composing
//
//  Created by Michael Tibollo on 2026-01-15.
//

import SwiftUI
import Theme

/// Visual style variants for buttons, each with distinct colors and styling.
public enum ButtonVariant: CaseIterable, Identifiable {
    public var id: Self { self }

    case primary
    case secondary
    case tertiary
    case destructive
}

/// A button component with loading state support and automatic haptic feedback.
///
/// Automatically shows a progress indicator when `isLoading` is true and provides
/// light impact haptic feedback on tap. Uses `LoadingButtonStyle` for styling.
///
/// Usage:
/// ```swift
/// LoadingButton(
///     title: "Save",
///     iconName: "square.and.arrow.down",
///     isLoading: isSaving,
///     variant: .primary
/// ) {
///     save()
/// }
/// ```
public struct LoadingButton: View {
    
    @Environment(\.tokens) private var tokens
    @Environment(\.hapticProvider) private var haptics
    
    let title: String
    let iconName: String?
    let isLoading: Bool
    let variant: ButtonVariant
    let action: () -> Void
    
    public init(
        title: String,
        iconName: String? = nil,
        isLoading: Bool = false,
        variant: ButtonVariant = .primary,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.iconName = iconName
        self.isLoading = isLoading
        self.variant = variant
        self.action = action
    }

    public var body: some View {
        Button {
            haptics.provide(.impact(.light))
            action()
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
