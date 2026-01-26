//
//  DestinationMapping.swift
//  workshop
//
//  Created by Michael Tibollo on 2026-01-26.
//

import SwiftUI
import Components
import Navigation

@ViewBuilder func view(for destination: PushDestination) -> some View {
    switch destination {
    case let .myPushDestination(model):
        MySampleView(myModel: model)
    }
}

@ViewBuilder func view(for destination: SheetDestination) -> some View {
    Group {
        switch destination {
        case let .mySheetDestination(model):
            MySampleView(myModel: model)
        }
    }
    .navigationBarTitleDisplayMode(.inline)
    .addDismissButton()
    .presentationDetents([.medium, .large])
    .presentationBackground(.regularMaterial)
}

@ViewBuilder func view(for destination: FullScreenDestination) -> some View {
    Group {
        switch destination {
        case let .myFullScreenDestination(model):
            MySampleView(myModel: model)
        }
    }
    .addDismissButton()
    .presentationBackground(.black)
}
