//
//  PhotoListPresenter.swift
//  Photos App
//
//  Created by Najeeb VenD on 10/08/2021.
//

import Foundation

protocol PhotoListPresentationLogic {
	func presentFetchedPhotos(_ photos: [Photo])
	func presentErrorInFetching(_ error: NetworkError)
}

class PhotoListPresenter {
	
	// MARK: Properties
	weak var viewController: PhotoListDisplayLogic?
	
}

// MARK: - Presentation Logic Methods
extension PhotoListPresenter: PhotoListPresentationLogic {
	
	func presentFetchedPhotos(_ photos: [Photo]) {
		viewController?.displayPhotos(photos)
	}
	
	func presentErrorInFetching(_ error: NetworkError) {
		viewController?.displayError(error.message)
	}
	
}
