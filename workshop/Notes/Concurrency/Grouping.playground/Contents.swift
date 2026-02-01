import Foundation
import SwiftUI

///
/// # Grouping Asynchronous Calls
/// Sometimes, we have multiple asynchronous pieces of work that need to be done but do not need to
/// happen sequentially. Because `await` will suspend the code when it is called, having two successive
/// (and again, not dependent) calls like this:
///
/// ```
/// files = try await model.getFiles()
/// status = try await model.getStatus()
/// ```
///
/// **Structured concurrency** allows us to use the `async let` binding syntax that groups several
/// asynchronous calls and awaits them all together. This is similar to a *promise* in other languages,
/// such that the bindings promise that either the values of the specific types or an error will be available
/// at a later point, and can only be accessed with `await`.
///
/// When calling `await`, if the value is already available it will be accessed immediately. Otherwise, the
/// code will suspend at the await until the result is available.
///
/// `async let` starts executing *before* calling `await`, running in parallel with the main code.
///

func getFiles() async throws -> [String] {
    return ["A.png", "B.pdf"]
}

func getStatus() async throws -> String {
    return "200"
}

func doAsyncWork() async throws {
    async let files = try getFiles()
    async let status = try getStatus()
    
    // some other code ...
    
    /// Here, we group the bindings into a tuple, but an array is also acceptable.
    let (filesResult, statusResult) = try await (files, status)
    
    // update view with results ...
}
