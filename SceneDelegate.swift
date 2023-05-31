//  SceneDelegate.swift
//  Giphy
//  Created by Erkan Emir on 13.05.23.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var coordinator: AppCoordinator?
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        coordinator = AppCoordinator(window: window!)
        coordinator?.start() 
    }

    func sceneDidDisconnect(_ scene: UIScene)       { }
    func sceneDidBecomeActive(_ scene: UIScene)     { }
    func sceneWillResignActive(_ scene: UIScene)    { }
    func sceneDidEnterBackground(_ scene: UIScene)  { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
}
