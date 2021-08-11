//
//  Utils.swift
//  Photos App
//
//  Created by Najeeb VenD on 11/08/2021.
//

import UIKit

class Utils {
	
	static func showErrorAlert(message: String, viewController: UIViewController) {
		showOkAlert(title: "Error", message: message, viewController: viewController)
	}
	
	static func showOkAlert(title: String = "", message: String, viewController: UIViewController) {
		let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
		showActionAlert(title: title, message: message, viewController: viewController, alertActions: [okAction])
	}
	
	static func showActionAlert(title: String = "", message: String, viewController: UIViewController, alertActions: [UIAlertAction]) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		for alertAction in alertActions {
			alertController.addAction(alertAction)
		}
		viewController.present(alertController, animated: true, completion: nil)
	}
	
	static func onMainThread(closure: @escaping () -> Void) {
		if Thread.isMainThread {
			closure()
		} else {
			DispatchQueue.main.async(execute: closure)
		}
	}

}
