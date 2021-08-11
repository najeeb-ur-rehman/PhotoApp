//
//  Photo.swift
//  Photos App
//
//  Created by Najeeb VenD on 10/08/2021.
//

import Foundation

struct Photo {
	let id: String
	let color: String
	let url: URL?
}

extension Photo: Decodable {
	
	enum CodingKeys: String, CodingKey {
		case id
		case color
		case urls
		
		enum UrlsCodingKeys: String, CodingKey {
			case full
		}
	}
	
	init(from decoder: Decoder) throws {
		let rootContainer = try decoder.container(keyedBy: CodingKeys.self)
		let urlsContainer = try rootContainer.nestedContainer(keyedBy: CodingKeys.UrlsCodingKeys.self, forKey: .urls)
		
		id = try rootContainer.decode(String.self, forKey: .id)
		color = try rootContainer.decode(String.self, forKey: .color)
		url = try urlsContainer.decode(URL.self, forKey: .full)
	}
}
