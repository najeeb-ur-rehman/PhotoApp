//
//  PhotoListBuilder.swift
//  Photos App
//
//  Created by Najeeb VenD on 11/08/2021.
//

import UIKit

class PhotoListBuilder {
	
	static func build() -> PhotoListViewController {
		let viewController = UIViewController.instantiate(PhotoListViewController.self, fromStoryboard: .Main)
		let photoService = PhotoRepository()
		let interactor = PhotoListInteractor(photoService)
		let presenter = PhotoListPresenter()
		
		viewController.interactor = interactor
		interactor.presenter = presenter
		presenter.viewController = viewController
		
		return viewController
	}
}
