import Foundation
import SwiftUI

///
/// # ACTORS
/// ## Overview
/// Actors are reference types that enable *safe access to shared mutable state in concurrent programming
/// environments*, without the need to create overhead for locks. Requests sent to an actor are placed in a
/// queue (called mailbox), and are processed serially.
///
/// When you encapsulate data within an actor, it is essentially being isolated from direct access from other
/// parts of the program.
///

///
/// ## Converting `class` to `actor`
/// When we create an `actor`, it becomes thread-safe. However, it is accessed with asynchronous patterns
/// like `async` and `await`, instead of simply accessing it the way you would with `class`. The process
/// of accessing something with an actor from outside of that actor is called **cross-actor reference**, and
/// when making a request like the example below, it gets added to the mailbox of the actor.
///
/// Furthermore, properties are *not mutable* from a cross-actor reference. Cross-actor property sets are
/// possible, but inout operations cannot be supported as an implicit suspension point between the `get`
/// and `set` could introduce race conditions.
///
/// By default, functions belonging to an actor are considered potentially asynchronous and therefore do not
/// need to be marked `async`.
///

actor Account {
    private let id: UUID = UUID()
    private var balance: Int = 20
    
    func withdraw(amount: Int) {
        guard balance >= amount else { return }
        self.balance = balance - amount
    }
}

var account = Account()
Task {
    await account.withdraw(amount: 10)
    /// `await account.balance = 42` ❌
}

///
/// ## Executors
/// The internal queue or mailbox of an actor is called a **Serial Executor**. It is similar to a **Serial
/// DispatchQueue**, but does not *strictly adhere to a FIFO policy*. Instead, it prioritizes tasks based
/// on factors like task priority instead of submission order.
///

///
/// ## Nonisolated Members
/// Nonisolated members allow parts of an actor to be accessed without the need for asynchronous calls.
/// This is useful for properties or methods that do not modify state.
///
extension Account {
    nonisolated func getAccountId() -> String {
        return "IBAN-" + id.uuidString
    }
}

///
/// ## Global Actors
/// An actor like `MainActor` is a global singleton instance of the main actor. To define our own global
/// singleton actors, we apply the `@globalActor` attribute to our declaration. It must implement a
/// `static` property named `shared`.
///
@globalActor
actor MyActor {
    
    static let shared = MyActor()
    
}
