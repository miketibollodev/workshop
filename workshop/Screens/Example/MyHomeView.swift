//
//  MyHomeView.swift
//  workshop
//
//  Created by Michael Tibollo on 2026-01-26.
//

import SwiftUI
import Navigation
import Models

struct MyHomeView: View {
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 50, height: 50)
                .foregroundStyle(.green)
            
            let model = MyModel()
            
            NavigationButton(push: .myPushDestination(model: model)) {
                Text("Push Destination")
            }
            
            NavigationButton(sheet: .mySheetDestination(model: model)) {
                Text("Sheet Destination")
            }
            
            NavigationButton(fullScreen: .myFullScreenDestination(model: model)) {
                Text("Full Screen Destination")
            }
        }
    }
}
