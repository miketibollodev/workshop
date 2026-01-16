//
//  HapticProvider.swift
//  Composing
//
//  Created by Michael Tibollo on 2026-01-16.
//

import SwiftUI

/// Protocol defining the interface for providing haptic feedback.
///
/// Implementations provide haptic feedback through UIKit's feedback generators.
/// Use `HapticProvider` for actual feedback, or `NoopHapticProvider` when haptics should be disabled.
public protocol HapticProviding {
    @MainActor func provide(_ style: HapticFeedbackStyle)
}

private struct HapticFeedbackProviderKey: EnvironmentKey {
    nonisolated(unsafe) static let defaultValue: HapticProviding =
        HapticProvider()
}

/// Environment key for accessing the haptic provider in SwiftUI views.
///
/// Set the provider in your app's root view:
/// ```swift
/// @main
/// struct MyApp: App {
///     @AppStorage("hapticsEnabled") private var hapticsEnabled: Bool = true
///
///     var body: some Scene {
///         WindowGroup {
///             RootView()
///                 .environment(
///                     \.hapticProvider,
///                     hapticsEnabled ? HapticProvider() : NoopHapticProvider()
///                 )
///         }
///     }
/// }
/// ```
///
/// Access it in views using `@Environment(\.hapticProvider)`.
public extension EnvironmentValues {
    var hapticProvider: HapticProviding {
        get { self[HapticFeedbackProviderKey.self] }
        set { self[HapticFeedbackProviderKey.self] = newValue }
    }
}

/// A no-op implementation that does not provide haptic feedback.
///
/// Use this when haptics should be disabled (e.g., based on user preferences, in tests, or on simulators).
public struct NoopHapticProvider: HapticProviding {
    public init() {}
    public func provide(_ style: HapticFeedbackStyle) {}
}

/// Provides haptic feedback using UIKit's feedback generators.
///
/// Usage:
/// ```swift
/// @Environment(\.hapticProvider) private var haptics
///
/// Button("Tap") {
///     haptics.provide(.impact(.medium))
/// }
/// ```
public struct HapticProvider: HapticProviding {
    public init() {}
    
    public func provide(_ style: HapticFeedbackStyle) {
        switch style {
        case .impact(let impact):
            let generator = UIImpactFeedbackGenerator(style: impact.uiStyle)
            generator.prepare()
            generator.impactOccurred()

        case .notify(let notify):
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(notify.uiType)

        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
    }
}

/// Defines the style of haptic feedback to provide.
///
/// Use `.impact` for button taps and physical interactions, `.notify` for system-level events,
/// and `.selection` for picker wheel changes.
public enum HapticFeedbackStyle {
    /// Impact feedback styles for physical interactions (button taps, etc.)
    public enum ImpactStyle: CaseIterable {
        case light
        case medium
        case heavy
        case rigid
        case soft
        
        var uiStyle: UIImpactFeedbackGenerator.FeedbackStyle {
            switch self {
            case .light: .light
            case .medium: .medium
            case .heavy: .heavy
            case .rigid: .rigid
            case .soft: .soft
            }
        }
    }
    
    /// Notification feedback styles for system-level events
    public enum NotifyStyle: CaseIterable {
        case success
        case warning
        case error
        
        var uiType: UINotificationFeedbackGenerator.FeedbackType {
            switch self {
            case .success: .success
            case .warning: .warning
            case .error: .error
            }
        }
    }
    
    case impact(ImpactStyle)
    case notify(NotifyStyle)
    case selection
}

