//
//  MyHomeScreen.swift
//  workshop
//
//  Created by Michael Tibollo on 2026-01-26.
//

import SwiftUI
import Models

struct MySampleView: View {
    
    let myModel: MyModel
    
    var body: some View {
        VStack {
            Text("Hello world!")
            
            Rectangle()
                .foregroundStyle(.red)
                .frame(width: 50, height: 50)
        }
    }
}
