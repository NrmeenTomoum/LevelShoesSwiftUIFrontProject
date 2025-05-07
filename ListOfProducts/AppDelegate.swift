//
//  AppDelegate.swift
//  ListOfProducts
//
//  Created by Nermeen Tomoum on 07/05/2025.
//
import UIKit
import SwiftUI
import Combine
import Foundation

@MainActor
final class AppDelegate: UIResponder, UIApplicationDelegate {

    private lazy var environment = AppEnvironment.bootstrap()
 //   private var systemEventsHandler: SystemEventsHandler { environment.systemEventsHandler }

    var rootView: some View {
        environment.rootView
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let config: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        config.delegateClass = SceneDelegate.self
      //  SceneDelegate.register(systemEventsHandler)
        return config
    }
}

// MARK: - SceneDelegate

@MainActor
final class SceneDelegate: UIResponder, UIWindowSceneDelegate, ObservableObject {

//    private static var systemEventsHandler: SystemEventsHandler?
//    private var systemEventsHandler: SystemEventsHandler? { Self.systemEventsHandler }

//    static func register(_ systemEventsHandler: SystemEventsHandler?) {
//        Self.systemEventsHandler = systemEventsHandler
//    }

//    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
//        systemEventsHandler?.sceneOpenURLContexts(URLContexts)
//    }
//
//    func sceneDidBecomeActive(_ scene: UIScene) {
//        systemEventsHandler?.sceneDidBecomeActive()
//    }
//
//    func sceneWillResignActive(_ scene: UIScene) {
//        systemEventsHandler?.sceneWillResignActive()
//    }
}
