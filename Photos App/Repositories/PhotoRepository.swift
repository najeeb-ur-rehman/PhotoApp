//
//  PhotoRepository.swift
//  Photos App
//
//  Created by Najeeb VenD on 10/08/2021.
//

import Foundation

typealias PhotosResult = Result<[Photo], NetworkError>

enum NetworkError: Error {
	case invalidURL
	case invalidResponse
	case requestFailed(withError: Error)
	
	var message: String {
		switch self {
		case .invalidURL: return "Invalid URL"
		case .invalidResponse: return "Invalid Response"
		case .requestFailed(let error): return "HTTP Request Failed with error: , \(error.localizedDescription)"
		}
	}
}

protocol PhotoService {
	func fetchPhotosPage(_ pageNo: Int, withCompletion completion: @escaping (PhotosResult) -> Void)
}

class PhotoRepository: PhotoService {
	
	private let photosURL: (Int) -> URL? = { pageNo in
		URL(string: "https://api.unsplash.com/photos/?page=\(pageNo)&client_id=ahk_jaCgZUdctIRQDWXktKC7w1_9Q1HM4himDvgYLYI")
	}

	func fetchPhotosPage(_ pageNo: Int, withCompletion completion: @escaping (PhotosResult) -> Void) {
		guard let url = photosURL(pageNo) else {
			completion(.failure(.invalidURL))
			return
		}
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let data = data {
				if let photos = try? JSONDecoder().decode([Photo].self, from: data) {
					completion(.success(photos))
				} else {
					completion(.failure(.invalidResponse))
				}
			} else if let error = error {
				completion(.failure(.requestFailed(withError: error)))
			}
		}
		task.resume()
	}
}
