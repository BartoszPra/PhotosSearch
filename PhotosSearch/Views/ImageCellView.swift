//
//  ImageCellView.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import SwiftUI

struct ImageCellView: View {
	
	@State var selectedTag: Int?
	var imageViewModel: ImageViewModel
	private let imageWidth = 110.0
	private let cellHeight = 130.0
	
	
	var body: some View {
		if let url = imageViewModel.thumbnailPhotoImageUrl {
			HStack {
				Button(action: {selectedTag = 2}) {
					CachedAsyncImage(url: url) { phase in
						if let image = phase.image {
							image
						} else if phase.error != nil {
							Image(systemName: "questionmark")
						} else {
							ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .blue))
						}
					}.frame(width: imageWidth)
						.frame(height: cellHeight - 10)
						.cornerRadius(10)
				}.background(link(id: 3))
				ImageDescriptionView(image: imageViewModel)
				Spacer()
			}.buttonStyle(.borderless)
		} else {
			HStack {
				Image(systemName: "questionmark")
								.frame(width: imageWidth)
								.frame(height: cellHeight - 10)
								.cornerRadius(10)
							ImageDescriptionView(image: imageViewModel)
							Spacer()
			}
		}
	}
	
	func link(id: Int) -> some View {
		NavigationLink("",
					   destination: DetailPage(vm: DetailPageViewModel(id: imageViewModel.photoId, urlString: imageViewModel.largeImageUrlString, title: "Photos")),
					   tag: 2,
					   selection: $selectedTag
		).hidden()
	}
}

struct ImageCellView_Previews: PreviewProvider {
    static var previews: some View {
		ImageCellView(imageViewModel: ImageViewModel(photo: Photo.sample, canNavigateToUser: true))
    }
}
