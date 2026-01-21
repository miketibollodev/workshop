//
//  Environment.swift
//  workshop
//
//  Created by Michael Tibollo on 2026-01-21.
//

import SwiftUI
import Observation

///
/// The *environment* in SwiftUI is a dependency injection pattern
/// that allows data to be shared across views in the view hierarchy. This
/// could take the form of a function, a state, a value type, or a reference type.
///
/// SwiftUI includes a variety of predefined values stored in the
/// `EnvironmentValues` struct, such as `verticalSizeClass`,
/// `dismiss`,  and `locale`.
///
/// Values from the environment are read using the `@Environment`
/// property wrapper. While some environment values are read-only, an
/// environment value can be set by using the `environment()` modifier.
/// This strictly propogates downwards into the child views, where applied.
/// This is also the reason why we tend to use `environment()` at the app entry
/// point level, as all child views will be able to read that environment value.
///

///
/// Custom environment values are added by extending `EnvironmentValues`
/// and defining a property with the `@Entry` macro. This creates an environment
/// key with a default value. It does *not* store state, manage lifetime, or sync updates.
///
extension EnvironmentValues {
    @Entry var colorFill: Color = .blue
}

struct ColorsView: View {
    
    @Environment(\.colorFill) var color
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 50, height: 50)
                .foregroundStyle(.green)
            
            VStack {
                Rectangle()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(color)
                
                Button("Change color") {
                    print("Change")
                }
            }
        }
    }
}


///
/// Prior to iOS 17, the environment was primarily used for value types.
/// With `Observation`, we can also use reference types, and it has been
/// simplified.
///
/// For example, instead of using a key, SwiftUI assumes there will only ever
/// be one instance of a class, when injecting a class in the following manner
/// to the environment. Alternatively, we can use `@Entry`.
///
/// Regardless of preference, through the `@Entry` macro or by using the type itself
/// as a key, if we want state for our type in the environment, we need to have it
/// managed somewhere. Thus, in this example, we use the `environment()` modifier
/// instead of just `@Entry`. This injects a specific instance into the environment (instead of
/// relying on the default), and allows us to update it and its properties.
///
@Observable
class DataModel {
    var count = 0
}

/// Again, this defines a key and a default value.
extension EnvironmentValues {
    @Entry var dataModelA: DataModel = .init()
}

struct MyDummyApp: View {
    
    /// This is set as a `@State` property instead of just passing it directly like
    /// `environment(DataModel())`, because if the body of `MyDummyApp`
    /// redraws, then the instance gets recreated. If we want persistent state, then
    /// we need this view to own it.
    @State var dataModelA = DataModel()
    
    @State var dataModelB = DataModel()
    
    var body: some View {
        MyFirstView()
            .environment(\.dataModelA, dataModelA)
            .environment(dataModelB)
    }
}

struct MyFirstView: View {
    
    /// We can access specific properties instead of the whole instance
    @Environment(\.dataModelA.count) private var countA
    
    @Environment(DataModel.self) private var dataModelB
    
    var body: some View {
        VStack {
            Text("dataModelA count: \(countA)")
            
            Button("Increment \(dataModelB.count)") {
                dataModelB.count += 1
            }
        }
    }
}


#Preview {
    MyDummyApp()
}
