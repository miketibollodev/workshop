import Foundation
import SwiftUI

///
/// # CONCURRENCY INTRODUCTION
/// ## Introduction
/// **Asynchronous code** can be suspend and resumed later, although only one piece of the program
/// executes at a time.
///
/// **Parallel code** runs multiple pieces of code simultaneously, like a four-core processor running four
/// pieces of code at a time.
///
///


///
/// ## Main Actor
/// By default, programs run on the main thread. The main thread and all of its data is represented by the
/// `@MainActor`. There is no concurrency on the main actor, because it only consists of one main thread,
/// or in other words, code is isolated to the main actor.
///


///
/// ## Asynchronous Functions
/// Asynchronous functions are those that can be suspended during execution. The function is marked by
/// `async`, and points where code can suspend are marked with `await`. This stops code from running
/// on the current thread until the event it waits for happens, then resumes execution. Other code will run on
/// the thread while it is yielding the thread. Many of the library APIs, like `URLSession`, will offload work to
/// the background automatically. Ultimately, it is up to the system to determine when the executing should
/// resume to the suspension point.
///
/// Asynchronous code can be called from a few places:
/// - Code in the bdy of an `async` function, method, or property
/// - Code in the static `main()` method of a class, structure, or enumeration marked by `@main`
/// - Code in an unstructed child task
///
func fetchImage(_ url: URL) async throws -> Image {
    let (data, response) = try await URLSession.shared.data(from: url)
    let uiImage = UIImage(data: data)
    return Image(uiImage: uiImage!)
}


///
/// ## Asynchronous Sequences
/// Sequences allow one element of a collection to be consumed at a time asynchronously, instead of all
/// at once. Each item is marked with `await`, like this `for` loop to indicate that each iteration can
/// possibly suspend.
///
func fetchFile() async throws {
    let handle = FileHandle.standardInput
    for try await line in handle.bytes.lines {
        print(line)
    }
}


///
/// ## Calling Asynchronous Functions in Parallel
/// When there are multiple pieces of asynchronous work to be done, but do not need to happen sequentially,
/// we can call them in parallel. For example, the following code would be inefficient as each image would
/// suspend, fully download, then return until the next could be downloaded:
///
/// ```
/// let url = URL(string: "https://picsum.photos/300")!
/// let firstImage = await fetch fetchImage(url)
/// let secondImage = await fetch fetchImage(url)
/// ```
///
/// To call an asynchronous function and let it run in parallel with code around it, we write `async let`
/// when defining a constant, then access it with `await`. This creates an asynchronous binding that
/// is similar to a *promise* in other languages. It promises to be available at some point in the future.
///
/// Where defined, the `async let` constants will start running their code in parallel. Only when we
/// access them later with `await` do we pause execution and wait to ensure their availability. In some
/// cases, the data may already be available.
///
/// Using `async let` implicitly creates a child task.
///
func fetchImages() async throws -> [Image] {
    let url = URL(string: "https://picsum.photos/300")!
    async let firstImage = fetchImage(url)
    async let secondImage = fetchImage(url)
    
    let images = try await [firstImage, secondImage]
    return images
}


///
/// ## Unstructured Concurrency
/// **Tasks** are units of work that can run asynchronously. In concurrency, tasks can be arranged in
/// a hierarchy, where each task in a given task group will have the same parent task, and each task
/// can have child tasks.
///
/// **Unstructured concurrency** involves having tasks that do not have parent tasks.
///
/// `Task` is a type that represents a top-level asynchronous task, meaning it can create an asynchronous
/// context from a synchronous context. `Task(name:priority:operation:)` creates a task that
/// defaults to running with the same actor isolation, priority, and task-local state as the current task/context.
/// `Task.detached(name:priority:operation:)` creates a detached task, which runs without
/// any actor isolation and does not inherit the current task/context priority or task-local state.
///
/// *Side note*: in the following view, even though the task is created from the main thread and will inherit
/// the priority from the main thread, execution can resume on a different thread after the `await`. For any
/// UI-related code, we need to execute it on the main thread. One way to handle this is explicitly calling
/// `MainActor.run()`. Another recommended option is to apply the `@MainActor` attribute to the
/// function declaration, if it can be run on the main thread, which ensures all code in that function will be
/// isolated to the main thread. When in a closure, we could also write `@MainActor` in the capture list,
/// like so:
/// ```
/// Task { @MainActor in
///     // Do some work ...
/// }
/// ```
///

struct ImageDisplayView: View {
    @State private var imageTask: Task<Void, Error>?
    @State var images: [Image]
    
    var body: some View {
        VStack {
            VStack {
                ForEach(images.indices, id: \.self) { index in
                    images[index]
                }
            }
            
            Button("Download Images") {
                imageTask = Task {
                    let images = try await fetchImages()
                    await MainActor.run {
                        self.images = images
                    }
                }
                
                /// We can also specify a return type for the task, and get the value at a later point.
                /// For example:
                ///
                /// ```
                /// imageTask = Task {
                ///     return try await fetchImages()
                /// }
                /// let images = await imageTask.value
                /// ```
            }
            
            Button("Cancel Download") {
                imageTask?.cancel()
            }
        }
    }
}


///
/// ## Structured Concurrency
/// **Structured concurrency** leverages the hierarchy of tasks to perform work. This explicit
/// relationship between tasks and task groups have some advantages:
/// - Parent tasks must wait for its child tasks to complete
/// - Child tasks that are set a higher priority buble up and escalate the parent priority
/// - When a parent task is cancelled, all child tasks are cancelled
/// - Task-local values propogate to child tasks automatically
///
/// The following task group creates a child task for each operation (downloading an image), and will be
/// added to the `images` array every time an image becomes available.
///
func downloadImage(name: String) async -> Image {
    try! await Task.sleep(for: .seconds(2))
    return Image(name)
}

let images = await withTaskGroup(of: Image.self) { group in
    let names = ["shoe", "candy", "bell"]
    for name in names {
        group.addTask {
            return await downloadImage(name: name)
        }
    }
    
    var images: [Image] = []
    for await image in group {
        images.append(image)
    }
    
    return images
}


///
/// ## Task Cancellation
/// Tasks are cancelled in a cooperative cancellation model. Each task checks whether it has been
/// cancelled at the appropriate points in its execution. Depending on the task, the typical responses to
/// cancellation include:
/// - Throw a `CancellationError`
/// - Returning `nil` or an empty collection
/// - Returning partially completed work
///
/// The two ways a task can check for cancellation and stop running if it is cancelled is through
/// `Task.checkCancellation()` or reading the `Task.isCancelled` property. Calling
/// `checkCancellation()` throws an error if the task is cancelled, which could then be used to
/// propogate and stop all of the task's work.
///
let newImages = await withTaskGroup { group in
    let names = ["shoe", "candy", "bell"]
    for name in names {
        let added = group.addTaskUnlessCancelled {
            Task.isCancelled ? nil : await downloadImage(name: name)
        }
        guard added else { break }
    }
    
    var images: [Image] = []
    for await image in group {
        if let image { images.append(image) }
    }
    
    return images
}


///
/// ## Isolation
/// Data isolation is the concept that code is not being modified outside of the current thread. There are three
/// main ways to isolate data:
/// - Immutable data is always isolated, because constants cannot be modified
/// - Data referenced by only the current task is always isolated
/// - Data that is protected by an actor is isolated if the code acessing that data is also isolated to the actor
///
/// When we want to explicitly state that data is *not isolated to a specific actor*, we can use `nonisolated`.
/// This is used primarily in actors when they have methods that do not mutate shared state. It can also be used to
/// in libraries to indicate that a function can be called on any actor that the developer using the library chooses.
///
nonisolated func decode(_ data: Data) async {
    // Do some decoding ...
}


///
/// ## Sendable Types
/// Some data is safe to share across threads because it does not have mutable state. These are called *sendable
/// types*. To mark a type as being sendable, it must conform to the `Sendable` protocol, either in the declaration
/// of a type or using the `@Sendable` attribute for functions and closures. There are three ways for a type to be
/// considered sendable:
/// - The type is a value type
/// - The type does not have any mutable state, and its immutable state is made up of other sendable data (i.e., a
///     read-only class with value type properties)
/// - The type has code that ensures the safety of its mutable state (i.e., a class marked with `@MainActor`)
///


///
/// ## Concurrency
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
