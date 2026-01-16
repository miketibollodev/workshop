//
//  ButtonVariant.swift
//  Composing
//
//  Created by Michael Tibollo on 2026-01-15.
//

import SwiftUI
import Styling

public enum ButtonVariant: CaseIterable, Identifiable {
    public var id: Self { self }

    case primary
    case secondary
    case tertiary
    case destructive
}


public struct LoadingButton: View {
    
    @Environment(\.styling) private var styling
    
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
        Button(action: action) {
            ZStack {
                ProgressView()
                    .opacity(isLoading ? 1 : 0)
                
                HStack(alignment: .center, spacing: styling.spacing.space2) {
                    Text(title)
                        .font(styling.typing.label.large)
                    
                    if let iconName {
                        Image(systemName: iconName)
                            .resizable()
                            .frame(
                                width: styling.spacing.space4,
                                height: styling.spacing.space4
                            )
                    }
                }
                .opacity(isLoading ? 0 : 1)
            }
        }
        .buttonStyle(LoadingButtonStyle(variant: variant))
        .disabled(isLoading)
    }
}
