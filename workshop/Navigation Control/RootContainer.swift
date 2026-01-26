//
//  RootContainer.swift
//  workshop
//
//  Created by Michael Tibollo on 2026-01-26.
//

import SwiftUI
import Navigation

struct RootContainer: View {
    
    @State var router: Router = .init(level: 0, identifierTab: nil)
    
    var body: some View {
        TabView(selection: $router.selectedTab) {
            Tab("Home", systemImage: "house", value: TabDestination.home) {
                MyHomeView()
            }
            
            Tab("Profile", systemImage: "person", value: TabDestination.profile) {
                MyHomeView()
            }
        }
    }
}
