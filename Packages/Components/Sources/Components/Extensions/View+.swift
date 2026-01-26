//
//  View+.swift
//  Components
//
//  Created by Michael Tibollo on 2026-01-25.
//

import SwiftUI

extension View {
    func frame(_ size: CGSize, alignment: Alignment = .center) -> some View {
        self.frame(
            width: size.width,
            height: size.height,
            alignment: alignment
        )
    }
}
