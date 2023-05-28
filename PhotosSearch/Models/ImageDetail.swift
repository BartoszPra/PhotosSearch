//
//  ImageDetail.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import Foundation

// MARK: - ImageDetail
struct ImageDetail: Codable {
	let photo: ImageDetails
	let stat: String
}

// MARK: - Photo
struct ImageDetails: Codable {
	let id, secret, server: String
	let farm: Int
	let dateuploaded: String
	let owner: Owner
	let title, description: Comments
	let comments: Comments
	let tags: Tags

	enum CodingKeys: String, CodingKey {
		case id, secret, server, farm, dateuploaded
		case owner, title, description, comments, tags
	}
}

// MARK: - Comments
struct Comments: Codable {
	let _content: String?

	enum CodingKeys: String, CodingKey {
		case _content
	}
}

// MARK: - Owner
struct Owner: Codable {
	let nsid, username: String?

	enum CodingKeys: String, CodingKey {
		case nsid, username
	}
}

// MARK: - Tags
struct Tags: Codable {
	let tag: [Tag]
}

// MARK: - Tag
struct Tag: Codable, Identifiable {
	let id: String
	let _content: String?


	enum CodingKeys: String, CodingKey {
		case id
		case _content
	}
}

extension ImageDetails{
	func toViewModel(canNavigateToUser: Bool) -> ImageDetailViewModel {
		return ImageDetailViewModel(imageDetails: self)
	}
	
	static let sample = Self.init(id: "12345", secret: "secret", server: "1234", farm: 66, dateuploaded: "07.04.1999", owner: Owner(nsid: "12", username: "BP"), title: Comments(_content:"Sample Photo"), description: Comments(_content:"sample photo description"), comments: Comments(_content: "Thats the comment"), tags: Tags(tag:[Tag(id: "1", _content: "sample"), Tag(id: "2", _content: "test"),Tag(id: "3", _content: "app")]))

}

	
