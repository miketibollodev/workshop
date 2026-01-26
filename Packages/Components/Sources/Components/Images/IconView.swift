//
//  IconView.swift
//  Components
//
//  Created by Michael Tibollo on 2026-01-25.
//

import SwiftUI

struct IconView: View {
    
    var body: some View {
        Image(Icons.Filled.Action.home)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .foregroundStyle(.gray)
            .background(.green)
    }
}

#Preview {
    IconView()
}
