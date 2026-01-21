//
//  Attributes.swift
//  workshop
//
//  Created by Michael Tibollo on 2026-01-21.
//

import SwiftUI

///
/// Attributes are pieces of code that provide additional information to *types* and
/// *declarations*.
///
/// **Declaration Attributes**
/// Some common declaration attributes include:
/// - `@available`: the platform, OS, or language features for a declaration
/// - `@discardableResult`: silence warnings if the return value of a function is unusted.
/// - `@dynamicMemberLookup`: allows a class, struct, enum, or protocol to enable members
///     to be looked up by name at runtime.
/// - `@frozen`: marks an enum (and structs) to signal that their cases will not change in the
///     future.
/// - `@main`: marks that a struct, class, or enum is the top-level entry point for program flow.
/// - `@objc`: applied to any declaration that can be represented in Objective-C, for example
///     protocols, nongeneric enumerations, properties and methods of classes, etc.
/// - `@objcMembers`: applied to a *class* declaration to apply the `@objc` attribute to all
///     Objective-C compatiable members (i.e., properties, functions, etc.) of the class, its
///     extensions, and subclasses.
/// - `@preconcurrency`: supresses strict concurrency checking.
///
/// **Type Attributes**
/// Some common type attributes include:
/// - `@autoclosure`: applied to a closure parameter and automatically creates a closure from an
///     expression you pass in.
/// - `@escaping`: applied to a parameter's type in a function or method declaration to indicate
///     that the parameter's value can be stored for later execution (i.e., it can outlive the lifetime
///     of the call).
///

struct MyDynamicStructure {
    
    @available(iOS 26, *)
    func someFunction() {
        print("This is done")
    }
    
    @discardableResult
    func returnFunction() -> Bool {
        return Int.random(in: 0...10) % 2 == 0
    }
    
    func myAutoClosure(_ expression: @autoclosure () -> Void) {
        expression()
    }
    
    func usingAutoClosure() {
        /// Without `@autoclosure`, our function might look like:
        /// `myAutoClosure({ print("Hello!") })`
        myAutoClosure(print("Hello!"))
    }
}


@frozen
public enum MapDirections {
    case north, east, south, west
}

