//
//  PrimaryButton.swift
//  workshop
//
//  Created by Michael Tibollo on 2026-01-15.
//

import SwiftUI
import Components
import Observation

struct MyView2: View {
    @State private var loadingTask: Task<Void, Never>?
    @Capitalized var testingVar: String
    
    private var isLoading: Bool { loadingTask != nil }
    
    init(loadingTask: Task<Void, Never>? = nil) {
        self.loadingTask = loadingTask
        self._testingVar = Capitalized(wrappedValue: "d")
    }


    var body: some View {
        VStack(spacing: 5) {
            ForEach(ButtonVariant.allCases) { variant in
                LoadingButton(
                    title: "Press!",
                    iconName: "arrow.right",
                    isLoading: isLoading,
                    variant: variant
                ) {
                    guard loadingTask == nil else {
                        return
                    }

                    loadingTask = Task {
                        await performWork()

                        await MainActor.run {
                            loadingTask = nil
                        }
                    }
                }
                .disabled(false)
            }
        }
    }
    
    private func performWork() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
    }
}


