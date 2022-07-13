//
//  FactoryDemoApp.swift
//  FactoryDemo
//
//  Created by Michael Long on 6/2/22.
//

import SwiftUI
import Factory

@main
struct FactoryDemoApp: App {
    var body: some Scene {
//        let _ = SharedContainer.setupMocks()
//        WindowGroup {
//            NavigationView {
//                ContentView()
//            }
//            .navigationViewStyle(StackNavigationViewStyle())
//        }
        
        let _ = SharedContainer.setupDemoContainer()
        WindowGroup {
            NavigationView {
                ListViewModule().build()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
