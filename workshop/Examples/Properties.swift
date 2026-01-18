//
//  Properties.swift
//  workshop
//
//  Created by Michael Tibollo on 2026-01-17.
//

import SwiftUI
import Composing

///
/// There are several types of properties. Properties are values that are associated with a particular
/// class, structure, or enumeration.
///
/// **Stored Properties**: constant or variable stored as part of an instance of a class or a structure.
///
/// ```
/// var length: Int
/// ```
///
/// **Lazy Stored Properties**: property whose initial value is not calculated until it is first used. It is
/// always marked as `var` because its initial value might not be retrieved until after initialization.
///
/// ```
/// lazy var defaults = UserDefaults()
/// ```
///
/// **Computed Properties**: properties that do not store a value, using a getter and (optional) setter
/// to retrieve and set other properties and values indirectly.
///
/// ```
/// var center: CGPoint {
///     get {
///         CGPoint(x: origin.x + size.width / 2,
///                 y: origin.y + size.height / 2)
///     }
///     set {
///         origin.x = newValue.x - size.width / 2
///         origin.y = newValue.y - size.width / 2
///     }
/// }
/// ```
///
/// **Property Observers**: observe and respond to changes in a property's value, even if the new
/// value that gets set is the same as the old value.
///
/// ```
/// var totalSteps: Int = 0 {
///     willSet {
///         print("Setting total steps to \(newValue)")
///     }
///     didSet {
///         if totalSteps > oldValue {
///             print("Added \(totalSteps - oldValue) steps")
///         }
///     }
/// }
/// ```
///
///
/// **Type Properties**: the opposite of instance properties, which belong to an instance of a particular
/// type, these belong to the type itself (static properties).
///
/// ```
/// struct MyStruct {
///     static var someString = "Some string"
/// }
/// ```
///


///
/// Property wrappers are a type that wraps a given value to attach additional logic to it. Essentially,
/// it is no different than a property with a getter and setter, but is reusable around code.
///
/// It can be implemented using either a struct or class, annotated with `@propertyWrapper`, and
/// includes a *stored property* called `wrappedValue`, which tells the compiler which underlying
/// value is being wrapped.
///
@propertyWrapper struct Capitalized {
    
    private var maxLength: Int
    
    private var storedString: String
    
    /// We use an underlying value `storedString` to store the wrapped value, but we could
    /// have just as easily implemented it without an underlying stored property:
    ///
    /// ```
    /// var wrappedValue: String {
    ///    didSet { wrappedValue = wrappedValue.capitalized }
    /// }
    /// ```
    var wrappedValue: String {
        get { String(storedString.prefix(maxLength)) }
        set { storedString = newValue.capitalized }
    }
    
    /// When we set an initial value for a property, the compiler uses the `init(wrappedValue:)`
    /// initializer to set up the wrapper. Even if we have other initializers, this is the one that gets called.
    init(wrappedValue: String) {
        self.storedString = wrappedValue.capitalized
        self.maxLength = 24
    }
    
    /// Additional arguments are passed in parantheses before the property is defined:
    /// ```
    ///  @Capitalized(maxLength: 4) var anagram = "california"
    /// ```
    init(wrappedValue: String, maxLength: Int) {
        self.storedString = wrappedValue.capitalized
        self.maxLength = maxLength
    }
}
