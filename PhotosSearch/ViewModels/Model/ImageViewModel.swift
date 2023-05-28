//
//  ImageViewModel.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import Foundation


class ImageViewModel: ObservableObject, Identifiable {
	
	var photoId: String
	var userId: String
	var photoTitle: String
	var tagsString: String!
	var thumbnailPhotoImageUrl: URL?
	var server: String
	var userIconUrl: URL?
	var largeImageUrlString: String?
	var canNavigateToUser: Bool!
	
	init(photo: Photo, canNavigateToUser: Bool) {
		photoId = photo.id
		userId = photo.owner
		photoTitle = photo.title
		tagsString = photo.tags
		largeImageUrlString = photo.url_l
		self.canNavigateToUser = canNavigateToUser
		server = photo.server
		if let urlString = photo.url_t {
			thumbnailPhotoImageUrl = URL(string: urlString)
		}
		userIconUrl = ApiHelper.buildUserIconUrl(iconFarm: photo.farm, iconServer: photo.server, nsId: photo.owner)
	}
}
