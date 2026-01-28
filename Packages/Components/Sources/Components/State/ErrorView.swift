//
//  ErrorView.swift
//  Components
//
//  Created by Michael Tibollo on 2026-01-27.
//

import SwiftUI

public struct ErrorView: View {
    
    let error: Error
    
    // TODO: Custom standard error view
    public var body: some View {
        Text("Encountered error")
            .foregroundStyle(.red)
    }
}
