//
//  ImageDetailViewModel.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import Foundation


class ImageDetailViewModel: ObservableObject, Identifiable {
	
	var id: String
	var photoTitle: String
	var description: String
	var tags: [String] = [String]()
	var ownerId: String
	var ownerUserName: String
	
	init(imageDetails: ImageDetails) {
		self.id = imageDetails.id
		self.photoTitle = imageDetails.title._content ?? "No title"
		self.description = imageDetails.description._content ?? "No description"
		self.ownerId = imageDetails.owner.nsid ?? "No user id"
		self.ownerUserName = imageDetails.owner.username ?? "No username"
		self.tags = imageDetails.tags.tag.compactMap {$0._content}
	}
}
