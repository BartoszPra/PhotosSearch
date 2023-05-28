//
//  Images.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import Foundation

// MARK: - Images
struct Images: Codable {
	let photos: Photos
	let stat: String
}

// MARK: - Photos
struct Photos: Codable {
	let page, pages, perpage, total: Int
	let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable, Identifiable {
	let id: String
	let server: String
	let farm: Int
	let owner: String
	let title: String
	let tags: String
	let url_t: String?
	let url_l: String?

	enum CodingKeys: String, CodingKey {
		case id, owner, title, tags, server, farm
		case url_t, url_l
	}
}

extension Photo {
	func toViewModel(canNavigateToUser: Bool) -> ImageViewModel {
		return ImageViewModel(photo: self, canNavigateToUser: canNavigateToUser)
	}
	
	static let sample = Self.init(id: "BartoszPhotoId", server: "65535", farm: 66, owner: "Bartosz", title: "Sample Photo", tags: "tagg", url_t: "https://live.staticflickr.com/65535/52917340364_82faa5ed15_b.jpg", url_l: "https://live.staticflickr.com/65535/52917340364_82faa5ed15_c.jpg" )
}
