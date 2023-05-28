//
//  ImageDescriptionView.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import SwiftUI

struct ImageDescriptionView: View {
	
	@State var selectedTag: Int?
	let image: ImageViewModel
	
	
	var body: some View {
		if let url = image.userIconUrl {
			VStack(alignment: .leading) {
				Text("**\(image.photoId.capitalized)**")
					.font(.system(size: 20))
				
				Button(action: {selectedTag = 1})
				{
					HStack {
						CachedAsyncImage(url: url) { phase in
							if let image = phase.image {
								image
							} else if phase.error != nil {
								Image(systemName: "questionmark")
							} else {
								ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .blue))
							}
							
						}.frame(width: 48)
							.frame(height: 48)
							.cornerRadius(24)
						Text("**\(image.userId.capitalized)**")
							.font(.system(size: 15)).lineLimit(1)
					}
				}.background(link(id: 5))
				 .disabled(!image.canNavigateToUser)
				Text("*\(image.tagsString)*")
					.lineLimit(3)
					.font(.system(size: 15))
					.foregroundColor(.gray)
			}.buttonStyle(.borderless)
		} else {
			
		}
	}
	
	func link(id: Int) -> some View {
			NavigationLink("",
						   destination: ListPage(vm: ListPageViewModel(title: "User \(image.userId) photos", canNavigateToUser: false, dataUrl: ApiHelper.buildUserPhotosUrl(userId: image.userId))),
				tag: 1,
				selection: $selectedTag
			).hidden()
		}
}

struct ImageDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
		ImageDescriptionView(image: ImageViewModel(photo: Photo.sample, canNavigateToUser: true))
    }
}
