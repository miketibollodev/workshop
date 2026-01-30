//
//  BasicButton.swift
//  Components
//
//  Created by Michael Tibollo on 2026-01-30.
//

import SwiftUI
import Navigation
import Theme

/// `BasicButton` is a non-loading button designed for simple synchronous actions with no error or loading state handling and navigations without a data fetch before.
public struct BasicButton: View {
    
    @Environment(Router.self) private var router
    
    let title: String
    let iconName: String?
    let variant: ButtonVariant
    
    private var destination: Destination?
    private var action: (() -> Void)?
    
    public init(
        title: String,
        iconName: String? = nil,
        variant: ButtonVariant = .primary,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.iconName = iconName
        self.variant = variant
        self.action = action
        self.destination = nil
    }
    
    // MARK: - Navigation Initializers
    
    public init(
        title: String,
        iconName: String? = nil,
        variant: ButtonVariant = .primary,
        destination: Destination
    ) {
        self.title = title
        self.iconName = iconName
        self.variant = variant
        self.action = nil
        self.destination = destination
    }
    
    public init(
        title: String,
        iconName: String? = nil,
        variant: ButtonVariant = .primary,
        push destination: PushDestination
    ) {
        self.init(
            title: title,
            iconName: iconName,
            variant: variant,
            destination: .push(destination)
        )
    }
    
    public init(
        title: String,
        iconName: String? = nil,
        variant: ButtonVariant = .primary,
        sheet destination: SheetDestination
    ) {
        self.init(
            title: title,
            iconName: iconName,
            variant: variant,
            destination: .sheet(destination)
        )
    }
    
    public init(
        title: String,
        iconName: String? = nil,
        variant: ButtonVariant = .primary,
        fullScreen destination: FullScreenDestination
    ) {
        self.init(
            title: title,
            iconName: iconName,
            variant: variant,
            destination: .fullScreen(destination)
        )
    }

    public var body: some View {
        ButtonBody(
            variant: variant,
            title: title,
            iconName: iconName
        ) {
            if let destination {
                router.navigate(to: destination)
            } else {
                action?()
            }
        }
    }
}
