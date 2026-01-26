import Foundation
import SwiftUI

///
/// # Introduction
/// Any program run is, by default, run on the main thread. The main thread and all of its data
/// is represented by the `@MainActor`. There is *no concurrency on the main actor, because
/// there is only one main thread* that can run it. Code run on the main actor is therefore "isolated
/// to the main actor". By default, the compiler runs everything on the main actor, as if every declaration
/// were marked by `@MainActor`.
///


///
/// # Asynchronous Tasks
/// Asynchronous tasks can be used when waiting on data, like a network request, to prevent holding up the
/// main thread, which should be used for responsive tasks like updating the UI.
///
/// By marking the function with `async` and calling asynchronous code with `await`. This indicates where
/// the function might suspend - meaning it stops running on the current thread until the event it is waiting for happens,
/// then it resumes execution. Many library APIs, like `URLSession`, will offload work to the background automatically.
///
/// **This example is still not introducing concurrency, we simply improved responsiveness by using async
/// tasks, calling library APIs to offload work for us.**
///
func fetchAndDisplayImage(url: URL) async throws {
    let (data, response) = try await URLSession.shared.data(from: url)
    let image = await decodeImage(data)
    //view.displayImage(image)
}

///
/// Async functions run in a `Task`. Tasks execute independently of other code, and will run start to finish. Specific parts
/// of a task may run on the background when marked with `await`, but when there are multiple tasks in the system,
/// tasks will take turns on the main thread (interleaving). For example, if we call `fetchAndDisplayImage` and some other
/// `displayNews` function, the first task may enter the background upon hitting the `await` to fetch the image.
/// Then, the news task will run on the main thread until completed, then, the remainder of the image display task is run.
///
func onTapEvent() {
    let url = URL(string: "https://picsum.photos/300")
    Task {
        do {
            try await fetchAndDisplayImage(url: url!)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
}


///
/// # Concurrency
/// Concurrency allows work to be executed on a background thread, in parallel with the main thread. Again, in our
/// example above, we did not introduce concurrency: the `URLSession` API did it for us. For our `decodeImage`
/// function, we can introduce concurrency.
///
/// The `@concurrent` attribute tells the compiler to run the function in the background.
///
@concurrent
func decodeImage(_ data: Data) async -> Image {
    return Image(uiImage: UIImage(data: data)!)
}

///
/// The `nonisolated` keyword allows the function to be called from any thread. This is often used in libraries
/// where the developer using it can choose whether to call the function from the main thread or a background thread.
///
nonisolated
func decodeJSON(data: Data) async {
    print("Do some decoding...\(data.count)")
}


///
/// # Data Sharing
/// In our above example, data is passed between the main thread and background threads. For example, when we
/// start the task on the main thread, we pass the `url` to the background to fetch and decode the image. Then, an
/// `image` is given to the main thread for display.
///
/// Because `url` (type `URL`) is a value type, it is safe to send to a background thread as it is just a copy. Other code,
/// like a user inputting a new URL, has no effect on the background work as both threads have their own copy of `url`.
///
/// The `Sendable` protocol, that when conformed to, indicates that the type is always safe to share concurrently.
/// Value types from the library (i.e., `String`) conform to `Sendable`.  Some of the types like `Array` have special
/// conformances, where it is sendable only if the elements are. `@MainActor` marked types are implicitly sendable.
/// Structs and enums can be sendable only when all of their instance data is sendable.
///
