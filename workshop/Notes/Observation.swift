//
//  Observation.swift
//  workshop
//
//  Created by Michael Tibollo on 2026-01-17.
//

import SwiftUI
import Observation
import Components

///
/// `@Observable` is a macro that can *only be applied to classes* as part of the
/// `Observation` framework. It replaces the old pattern of `@ObservableObject`,
/// `@EnvironmentObject`, and `@StateObject`.
///
/// As of iOS 17, `@State` can be used behind simple value types to tell views of the
/// single source of truth for a class, like a view model.
///
@Observable
class MyClass {
    public var isSelected: Bool
    public var total: Int
    
    init() {
        self.isSelected = false
        self.total = 0
    }
}

struct MyView: View {
    @State var myClass: MyClass = .init()
    
    var body: some View {
        VStack {
            LoadingButton(title: "Increment") {
                myClass.total += 1
            }
            
            /// Note we do not pass `$myClass`, as this is not passing a binding of `MyClass`
            MyNestedView(myClass: myClass)
            
            MyReadOnlyView(total: myClass.total, isSelected: myClass.isSelected)
        }
    }
}


///
/// `@Bindable` is used for `@Observable` classes instead of `@Binding`, when a class
/// is owned by another view, but we need to mutate the underlying properties of that class.
/// `@Binding` is intended to bind to a *value* and does not participate in observation.
///
/// If we instead created a binding of `MyClass`, what we are really saying is to create
/// `Binding<MyClass>`, meaning it would only "observe" a change if a change happened to the
/// instance of `MyClass`. However, this is not what we are likely intentionally doing.
///
/// Instead, we use `@Bindable`, designed specifically for `@Observable` classes, which
/// instead tells a view that to track the *properties* the view reads from the class. So, it is actually
/// observing changes in the values and not the class instance itself.
///
struct MyNestedView: View {
    @Bindable var myClass: MyClass
    
    var body: some View {
        LoadingButton(title: "Select") {
            myClass.isSelected = !myClass.isSelected
        }
    }
}


///
/// Views that are read-only can simply accept properties from a class. It won't cause the view
/// to redraw or have any mutability. However, in `MyView`, due to `myClass` being used
/// to pass `total` and `isSelected`, it will redraw when there is a change because it
/// is observing those properties.
///
struct MyReadOnlyView: View {
    let total: Int
    let isSelected: Bool
    
    var body: some View {
        Text("Total: \(total)")
            .foregroundStyle(isSelected ? .blue : .red)
    }
}

#Preview {
    MyView()
}
