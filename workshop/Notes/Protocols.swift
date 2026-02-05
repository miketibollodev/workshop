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

// MARK: - Existential Types (any P)

///
/// An **existential type** is a value that can hold *any* concrete type conforming to a protocol.
/// The concrete type is chosen at runtime (by what you assign or pass in), so the compiler
/// does not know the specific type—only that it conforms to the protocol. In Swift 5.6+ you
/// write this explicitly as **`any Protocol`** (e.g. `any Greetable`).
///
/// When you write `let greeter: any Greetable = GermanGreeter()`, `greeter` is an existential:
/// you could later assign a different conforming type (if it were `var`), and functions
/// that take `any Greetable` accept any conforming implementation.
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

/// Existentials let one variable or collection hold multiple conforming types.
func exampleExistentialUsage() {
    var greeter: any Greetable = GermanGreeter()
    _ = greeter.greet() // "Hallo"

    greeter = EnglishGreeter()
    _ = greeter.greet() // "Hello"

    let all: [any Greetable] = [EnglishGreeter(), GermanGreeter()]
    _ = all.map { $0.greet() } // ["Hello", "Hallo"]
}

// MARK: - Generics vs Opaque (some P) vs Existential (any P)

///
/// **Generics:** The *caller* picks the type. The function must work for whatever `T` the caller
/// specifies. Example: `func decode<T: Decodable>(_ type: T.Type) -> T`.
///
/// **Opaque (`some P`):** The *callee* picks one concrete type and hides it from the caller.
/// The implementation always returns the same concrete type for that function; the caller only
/// sees “something that conforms to P.” The concrete type is not erased—the compiler knows it.
/// Used everywhere in SwiftUI (e.g. `body: some View`).
///
/// **Existential (`any P`):** The value can be *any* conforming type, and can change at runtime.
/// The compiler treats it as a container (a “box”) that can hold different concrete types.
/// Good for collections or parameters that must accept multiple conforming types.
///

protocol MyProtocol {
    associatedtype Identifier
    var id: Identifier { get set }
    var item: Int { get set }
}

struct StructA: MyProtocol {
    var id: String = "A"
    var item = 1
}

struct StructB: MyProtocol {
    var id: Int = 2
    var item = 3
}

/// **Generic:** Caller chooses `T`. Implementation must work for any `T: MyProtocol`.
func makeGeneric<T: MyProtocol>(_ value: T) -> T {
    value
}

/// **Opaque:** Callee chooses the concrete type (here, always `StructB`). Call site only sees “some MyProtocol”.
/// You cannot return `StructA()` from this function—the return type is fixed to one concrete type.
func makeOpaque() -> some MyProtocol {
    StructB()
}

/// **Existential:** Caller can pass any conforming type; concrete type can differ per call.
/// Use `object.item` (same type for all conformers). Using `object.id` is possible but its type is type-erased.
func useExistential(_ object: any MyProtocol) {
    print(object.item)
    print(object.id) // type is opaque when used through `any MyProtocol`
}

///
/// Why not return plain `MyProtocol`? Protocols with **associated types** don’t have a single
/// concrete type for their requirements (e.g. `Identifier` is `String` for StructA, `Int` for StructB),
/// so the compiler can’t express “returns a MyProtocol” without either hiding the type (`some`) or
/// allowing any conformer (`any`). Returning `some MyProtocol` lets the implementation fix the
/// concrete type while hiding the identity of that type from the caller.
///
