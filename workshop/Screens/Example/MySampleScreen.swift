//
//  MyHomeScreen.swift
//  workshop
//
//  Created by Michael Tibollo on 2026-01-26.
//

import SwiftUI
import Components
import Models
import Navigation

// MARK: - View Model

protocol SampleViewActions: AnyObject {
    func refreshSimple() async throws
    func refreshButton() async throws
    func refreshNavigation() async throws -> [String]?
}

@Observable
class MySampleViewModel {
    
    var state: LoadingState<[String]>
    var iteration: Int
    
    init(
        state: LoadingState<[String]> = .idle,
        iteration: Int = 1
    ) {
        self.state = state
        self.iteration = iteration
    }
    
    func fetchData(model: MyModel) async throws -> [String] {
        return ["A", "B", "C", "D"]
    }
}

extension MySampleViewModel: SampleViewActions {
    func refreshSimple() async throws {
        state = .loading
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        state = .dataLoaded(["E", "F", "G", "H"])
        iteration += 1
    }
    
    func refreshButton() async throws {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        state = .dataLoaded(["I", "J", "K", "L"])
        iteration += 1
    }
    
    func refreshNavigation() async throws -> [String]?  {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        return ["M", "N", "O", "P"]
    }
}

// MARK: - Views

struct MySampleScreen: View {
    
    @State var viewModel: MySampleViewModel = .init()
    let myModel: MyModel
    
    var body: some View {
        StateView(
            state: $viewModel.state,
            dataContent: { data in
                MySampleView(
                    data: data,
                    actions: viewModel,
                    iteration: viewModel.iteration
                )
            },
            fetchData: {
                try await viewModel.fetchData(model: myModel)
            }
        )
    }
}

struct MySampleView: View {
    
    @Environment(Router.self) private var router
    
    let data: [String]
    var actions: SampleViewActions?
    let iteration: Int
    
    var body: some View {
        VStack {
            Text("ITERATION: \(iteration)")
            
            ForEach(data, id: \.self) { text in
                Text(text)
            }
            
            MySampleNestedView(
                actions: actions
            )
            
            LoadingButton(title: "Refresh (loading)") {
                try await actions?.refreshButton()
            }
            
            LoadingButton(
                title: "Refresh (navigate)",
                fetchData: { try await actions?.refreshNavigation() },
                action: { data in
                    router.navigate(to: .push(.myPushDestination(model: .init())))
                }
            )
        }
    }
}

struct MySampleNestedView: View {
    
    var actions: SampleViewActions?
    
    var body: some View {
        Button("Refresh (simple)") {
            Task {
                try await actions?.refreshSimple()
            }
        }
    }
}
