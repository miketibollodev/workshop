//
//  PrimaryButton.swift
//  workshop
//
//  Created by Michael Tibollo on 2026-01-15.
//

import SwiftUI
import Styling

struct MyView: View {
    @State var isDisabled = false
    
    var body: some View {
        HStack(spacing: 0) {
            Button("Press", role: .confirm) {
                print("Done!")
            }
            .buttonStyle(.primary)
            .disabled(isDisabled)
            Button("Press", role: .confirm) {
                print("Done!")
            }
            .buttonStyle(.primary)
            .disabled(isDisabled)
            
        }
    }
}

#Preview {
    MyView()
}

/*
 As of Swift 5.5, we can extend things like `ButtonStyle` to include custom implementations. This allows for easy access when assigning a button style, such as `.buttonStyle(.primary)`.
 
 */

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle { .init() }
}

/*
 SwiftUI provides the disabled state through the environment, thus `isEnabled` allows us to access the `disabled` modifier on buttons directly.
 
 `configuration.label` refers to the button `Label`, which is just a type-erased `View` that is provided to the button. For most purposes this is the `Text` generated from the `title` of a button, but can also be other things when passed through the `label` property.
 */


struct PrimaryButtonStyle: ButtonStyle {
    
    @Environment(\.styling) private var styling
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center, spacing: 6) {
            configuration.label
                .font(.system(size: 16, weight: .semibold))

            Image(systemName: "arrow.right")
                .resizable()
                .frame(width: 16, height: 16)
            
        }
        .padding(.horizontal, styling.spacing.space4)
        .padding(.vertical, styling.spacing.space3)
        .foregroundStyle(styling.coloring.surface.primary)
        .background(.green)
        .cornerRadius(12)
        .opacity(isEnabled ? 1.0 : 0.5)
    }
}

/*
 - icon enabled/disabled -> if passed an icon name
 - icon name
 - type
 - enabled/disabled
 
 after:
 - padding/sizes
 
 
 6 gap, 16 h padding, 12 v padding, 12 radius, 16x16 icon
 */
