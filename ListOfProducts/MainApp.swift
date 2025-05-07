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

//    private var onChangeHandler: (EnvironmentValues.Diff) -> Void {
//        return { diff in
//            if !diff.isDisjoint(with: [.locale, .sizeCategory]) {
//                self.diContainer.appState[\.routing] = AppState.ViewRouting()
//            }
//        }
//    }

