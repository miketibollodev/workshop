//
//  Result Builders.swift
//  workshop
//
//  Created by Michael Tibollo on 2026-01-25.
//

import SwiftUI

///
/// Result builders are a type that you define that adds syntax for creating
/// nested data. The `@ViewBuilder` attribute is an example of a result builder.
///
/// Suppose we had a function on a `UIViewController` that would add `NSLayoutConstraint`
/// to an array based on some sort of conditional logic.
/// ```
/// override func viewDidLoad() {
///     super.viewDidLoad()
///
///     var constraints: [NSLayoutConstraint] = []
///
///     if isPortrait {
///         constraints.append(iconImageView.topAnchor.constraint(equalTo: ...)
///     } else {
///         constraints.append(iconImageView.bottomAnchor.constraint(equalTo: ...)
///     }
///
///     if let mode = mode {
///         constraints.append(iconImageView.widthAnchor.constraint(equalTo: ...)
///     }
///
///     NSLayoutConstraint.activate(constraints)
/// }
/// ```
///
/// Result builders would allow us to define our own result builder type, that could be used like this:
/// ```
/// @AutoLayoutBuilder var constraints: [NSLayoutConstraint] {
///     if isPortrait {
///         constraints.append(iconImageView.topAnchor.constraint(equalTo: ...)
///     } else {
///         constraints.append(iconImageView.bottomAnchor.constraint(equalTo: ...)
///     }
///
///     if let mode = mode {
///         constraints.append(iconImageView.widthAnchor.constraint(equalTo: ...)
///     }
///
///     label.constraintsForAnchoringTo(boundsOf: view)
/// }
/// ```
///
@resultBuilder
struct AutoLayoutBuilder {
    
    static func buildBlock(_ components: NSLayoutConstraint...) -> [NSLayoutConstraint] {
        return components
    }
    
    static func buildExpression(_ expression: NSLayoutConstraint) -> [NSLayoutConstraint] {
        return [expression]
    }

    static func buildExpression(_ expression: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        return expression
    }
    
    // Support for optionals
    static func buildOptional(_ components: [NSLayoutConstraint]?) -> [NSLayoutConstraint] {
        return components ?? []
    }
    
    // Support for if statements
    static func buildEither(first components: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        return components
    }

    // Support for if statements
    static func buildEither(second components: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        return components
    }
}

///
/// The implementation of `View` leverages `@ViewBuilder` to give us
/// the nested behaviour of SwiftUI.
///
/// ```
/// public protocol View {
///     associatedtype Body: View
///
///     @ViewBuilder var body: Self.Body { get }
/// }
/// ```
///
/// We often use `@ViewBuilder` when creating `View` functions or variables
/// that include conditionals or multiple types of `View`. Furthermore, we also
/// do not need to use explicit return statements.
///

struct SomeViewBuilderView: View {
    
    var body: some View {
        VStack {
            buttonOrText
        }
    }
    
    @ViewBuilder var buttonOrText: some View {
        if Bool.random() {
            Button("Press me!") { print("Pressed") }
        } else {
            Text("Text")
        }
    }
}
