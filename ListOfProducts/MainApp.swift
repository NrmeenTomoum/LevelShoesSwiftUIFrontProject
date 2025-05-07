//
//  MainApp.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 07/05/2025.
//

import SwiftUI

@main
struct MainApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            appDelegate.rootView
        }
    }
}

extension AppEnvironment {
    var rootView: some View {
                MainView()
                    .inject(diContainer)
        }
    }
