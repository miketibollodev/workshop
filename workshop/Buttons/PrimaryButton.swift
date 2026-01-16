//
//  PrimaryButton.swift
//  workshop
//
//  Created by Michael Tibollo on 2026-01-15.
//

import SwiftUI
import Composing

struct MyView: View {
    @State private var loadingTask: Task<Void, Never>?
    private var isLoading: Bool { loadingTask != nil }


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

#Preview {
    MyView()
}
