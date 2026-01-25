//
//  Closures.swift
//  workshop
//
//  Created by Michael Tibollo on 2026-01-25.
//

import SwiftUI

// MARK: - Closure Basics

///
/// Closures are self-contained blocks of code that captures (or *closes over*)
/// values from its environment. **Closures are reference types.**
///
/// A basic closure example may look something like this:
/// ```
/// let myData: [String] = ["Banana", "Apple", "Orange", "Peach"]
///
/// let mySortMethod = { (fruit1: String, fruit2: String) -> Bool in
///     return fruit1 < fruit2
/// }
///
/// let mySecondSortMethod: (Int, Int) -> Void = { int1, int2 in
///     return int1 < int2
/// }
///
/// mySortedData = myData.sorted(by: mySortMethod)
/// ```
///
/// Side note: `Void` is just a `typealias` of an empty tuple `()`
///
/// Capture lists specifies the values a closure captures from its environment.
/// Anything that we wish to use inside of a closure must be captured in the
/// capture list. For example, the following would fail to build unless we specified
/// `self` in the capture list.
///
class MyExampleClass {
    var counter = 1
    
    /// We use `lazy` here because otherwise `self` is not available to properties.
    /// Further, we use `weak self` as the closure will otherwise have a strong reference
    /// to `self`.
    lazy var closure: () -> Void = { [weak self] in
        guard let self else { return }
        print(self.counter)
    }
}

// MARK: - Escaping Closures

///
/// When closures are marked with `@escaping`, it means the closure will outlive or leave
/// the scope that the closure has been passed to (i.e., called after that function returns)..
/// A non-escaping closure is executed within the scope that it was passed to, like such:
/// ```
/// func doSomething(closure: () -> Void) {
///     closure() <-- this is non-escaping
/// }
/// ```
///
/// Prior to concurrency, completion handlers were common for performing async work.
/// In this simple example, we can see that a function that performs async work usually
/// has a trailing closure called `completion`.  When the work is completed, this closure
/// gets called, and the logic it is supposed to perform is set elsewhere.
///
/// When using escaping closures, it will implicitly capture any objects, values, or functions that
/// are referenced within it. That is to say, `[weak self]` may not be sufficient for our capture
/// lists if we reference other objects.
///
class MyDataClass {
    
    /// The completion handler returns `Void` because we are not getting a return value
    /// from the call of the closure. If we were, then we might write something like
    /// `let result = completion(23)`.
    func doSomeWork(_ completion: @escaping (Int) -> Void) {
        DispatchQueue.global().async {
            completion(23)
        }
    }
}

class MyReceivingClass {
    
    /// This shorthand syntax can be confusing, but we are essentially writing the logic
    /// of what to do with the value we receive from our async function, which will get
    /// called at a later point.
    func fetchData() {
        MyDataClass().doSomeWork { int in
            print("Integer received: \(int)")
        }
    }
}
