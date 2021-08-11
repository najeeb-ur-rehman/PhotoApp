//
//  SceneDelegate.swift
//  Photos App
//
//  Created by Najeeb VenD on 10/08/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		let photoListVC = PhotoListBuilder.build()
		let window = UIWindow(windowScene: windowScene)
		window.rootViewController = photoListVC
		self.window = window
		window.makeKeyAndVisible()
	}

}

