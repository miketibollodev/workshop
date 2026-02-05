//
//  Protocols.swift
//  workshop
//
//  Created by Michael Tibollo on 2026-02-05.
//

import Foundation
import UIKit

///
/// **Protocols** define a blueprint of methods, properties, and other requirements that
/// can be adopted by a class, structure, or enumeration. They enable polymorphism
/// and shared behavior without inheritance.
///

// MARK: - Protocol Basics & Default Implementations

///
/// A protocol declares what conforming types must implement. Types can provide
/// their own implementation or use a **default implementation** from an extension
/// on the protocol itself.
///
enum Language {
    case english, german, croatian
}

protocol Localizable {
    static var supportedLanguages: [Language] { get }
}

/// A **default implementation** is provided by extending the protocol. Conforming
/// types get this implementation unless they override it.
extension Localizable {
    static var supportedLanguages: [Language] {
        [.english]
    }
}

// MARK: - Immutable vs Mutable Conformance

///
/// **Immutable** conformance returns a new value; **mutable** conformance mutates
/// in place and requires `mutating`. Value types (struct, enum) choose based on
/// whether they need to support mutation.
///
/// ```
/// // Immutable: returns a new instance
/// func changed(to language: Language) -> Self
///
/// // Mutable: mutates in place (struct/enum only)
/// mutating func change(to language: Language)
/// ```
///
protocol ImmutableLocalizable: Localizable {
    func changed(to language: Language) -> Self
}

protocol MutableLocalizable: Localizable {
    mutating func change(to language: Language)
}

struct MyText: ImmutableLocalizable {
    static let supportedLanguages: [Language] = [.english, .croatian]

    var content = "Help"

    func changed(to language: Language) -> MyText {
        let newContent: String
        switch language {
        case .english: newContent = "Help"
        case .german: newContent = "Hilfe"
        case .croatian: newContent = "Pomoć"
        }
        return MyText(content: newContent)
    }
}

/// Example: using the immutable API. The original value is unchanged.
func exampleImmutableUsage() {
    let original = MyText(content: "Help")
    let localized = original.changed(to: .croatian)
    // original.content is still "Help"; localized.content is "Pomoć"
    _ = (original, localized)
}

// MARK: - Class-Constrained Protocols

///
/// You can limit protocol conformance to **subclasses of a specific class** using
/// `where Self: SomeClass`. This is common when the protocol uses reference semantics
/// or requires UIKit/AppKit types.
///
protocol LocalizableViewController where Self: UIViewController {
    func showLocalizedAlert(text: String)
}

/// A view controller can then conform and implement the requirement:
/// ```
/// class SettingsViewController: UIViewController, LocalizableViewController {
///     func showLocalizedAlert(text: String) {
///         let alert = UIAlertController(title: nil, message: text, preferredStyle: .alert)
///         present(alert, animated: true)
///     }
/// }
/// ```
///

// MARK: - RawRepresentable and Codable

///
/// `RawRepresentable`is a protocol that types use to convert to/from a raw value
/// (e.g. `String`, `Int`). Enums with a raw value type automatically gain
/// `RawRepresentable`, and the compiler can synthesize `Equatable`, `Hashable`,
/// and `Codable` for them.
///
/// `Codable` is a typealias of `Encodable & Decodable`, used for serialization.
///
/// Example of an enum that is both `RawRepresentable` and `Codable`:
/// ```
/// enum ApiMethod: String, Codable {
///     case get = "GET"
///     case post = "POST"
/// }
/// let data = try JSONEncoder().encode(ApiMethod.post) // encodes "POST"
/// ```
///
enum ApiMethod: String, Codable {
    case get = "GET"
    case post = "POST"
}

// MARK: - Existential Types

///
/// An **existential type** is a variable (or parameter) typed as a protocol. The
/// concrete type is not fixed at compile time—it’s “some type that conforms to
/// this protocol.” The type is determined by the value you assign at runtime.
///
/// When you write `let greeter: Greetable = GermanGreeter()`, `greeter` is an
/// existential: the compiler only knows it conforms to `Greetable`, not that it
/// is specifically `GermanGreeter`.
///
protocol Greetable {
    func greet() -> String
}

struct EnglishGreeter: Greetable {
    func greet() -> String { "Hello" }
}

struct GermanGreeter: Greetable {
    func greet() -> String { "Hallo" }
}

/// Using an existential: the same variable can hold any `Greetable` implementation.
func exampleExistentialUsage() {
    let greeter: Greetable = GermanGreeter()
    _ = greeter.greet() // "Hallo"

    // Could reassign to another conforming type:
    // greeter = EnglishGreeter()  // if greeter were var
}
