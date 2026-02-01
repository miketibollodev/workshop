import Foundation
import SwiftUI

///
/// # Tasks
/// `Task` is a type that represents a top-level asynchronous task, which means it can *create* an
/// asynchronous context from a synchronous context.
///
/// `Task(priority: operation:)` schedules an `operation` for asynchronous execution
/// with the given priority, and  t inherits defaults from the current synchronous context. This includes
/// the  priority.
///
/// `Task.detached(priority: operation:)` also schedules an `operation` but it does not
/// inherit the defaults of the calling context. This allows us to create a low or high priority task regardless
/// of the calling context.
///

///
/// In the following view, `Task` (without specifying the priority), is created from the main thread. It will
/// inherit the priority and run from the main thread too. However, when using `await`,  execution may
/// resume on a different thread. For any UI-related code, we need to execute it on the main thread.
///
/// One way to do this is `MainActor.run()`, however, it can become hard to read.
///
/// Another way is using the `@MainActor` attribute. This ensures that any code run in that declaration
/// will be isolated to the main thread.
///
struct DownloadView: View {
    
    @State var status: String = "No Status"
    
    var body: some View {
        VStack {
            Button("Download Task (MainActor.run())") {
                Task {
                    let message = await downloadTask()
                    
                    await MainActor.run {
                        self.status = message
                    }
                }
            }
            
            Button("Download Task (@MainActor)") {
                Task {
                    let message = await downloadTask()
                    updateStatus(message)
                }
            }
            
            Text(status)
        }
        
    }
    
    func downloadTask() async -> String {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        return "Download complete"
    }
    
    @MainActor func updateStatus(_ message: String) {
        status = message
    }
}
