//
//  PhotoListInteractor.swift
//  Photos App
//
//  Created by Najeeb VenD on 10/08/2021.
//

import Foundation

protocol PhotoListBusinessLogic {
	func fetchPhotosPage()
}

class PhotoListInteractor {
	
	// MARK: Properties
	var presenter: PhotoListPresentationLogic?
	
	private let photosService: PhotoService
	private var currentPage = 1
	private var isFetching = false

	init(_ service: PhotoService) {
		self.photosService = service
	}
}


// MARK: - Business Logic Methods
extension PhotoListInteractor: PhotoListBusinessLogic {
	
	func fetchPhotosPage() {
		guard !isFetching else {
			return
		}
		isFetching = true
		photosService.fetchPhotosPage(currentPage) { [weak self] result  in
			guard let self = self else {
				return
			}
			switch result {
			case .success(let photos):
				self.presenter?.presentFetchedPhotos(photos)
				self.currentPage += 1
			case .failure(let error):
				self.presenter?.presentErrorInFetching(error)
			}
			self.isFetching = false
		}
	}
	
}
