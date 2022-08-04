//
//  SceneDelegate.swift
//  template-swift-no-sb
//
//  Created by Glenn Adams on 7/30/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
 
        guard let ws = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: ws)
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
    }
}

