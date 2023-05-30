//
//  DetailPage.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import SwiftUI

struct DetailPage: View {
	
	@StateObject var vm: DetailPageViewModel
	
	var body: some View {
		VStack() {
			if let url = vm.url {
				CachedAsyncImage(url: url) { phase in
					if let image = phase.image {
						image.resizable()
							.aspectRatio(contentMode: .fit)
					} else if phase.error != nil {
						Image(systemName: "questionmark")
					} else {
						ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .blue))
					}
				}.frame(height: UIScreen.main.bounds.height/3)
					.frame(width: UIScreen.main.bounds.width - 5)
					.background(Color(.lightGray))
					.cornerRadius(15)
			} else {
				Image(systemName: "questionmark")
				.frame(height: UIScreen.main.bounds.height/3)
					.frame(width: UIScreen.main.bounds.width - 5)
					.background(Color(.lightGray))
					.cornerRadius(15)
			}
			
			VStack(alignment: .leading) {
				Text("Photo Id:  \(vm.id)")
				Text("Title: \(vm.imageDetailViewModel?.photoTitle ?? "")")
				Text("Username: \(vm.imageDetailViewModel?.ownerUserName ?? "")")
				ScrollView() {
					Text("Description: \(vm.imageDetailViewModel?.description ?? "")")
				}
			}.cornerRadius(10)
			.frame(
					minWidth: 0,
					maxWidth: .infinity,
					minHeight: 0,
					alignment: .leading
				)
			VStack() {
				if let model = vm.imageDetailViewModel {
					if (!model.tags.isEmpty) {
						Text("Tags")
						List() {
							ForEach(model.tags, id: \.self) { t in
								Text(t)
							}
						}.frame(maxWidth: .infinity, alignment:.top)
							.edgesIgnoringSafeArea(.all)
							.listStyle(PlainListStyle())
					} else {
						Spacer().background(.blue)
					}
				}
			}
		}
		.padding(10)
		.frame(
			minWidth: 0,
			maxWidth: .infinity,
			minHeight: 0,
			maxHeight: .infinity,
			alignment: .top
		)
		
		.navigationBarTitle(Text(""), displayMode: .inline)
		.task {
			vm.getGetDetailData()
		}
	}
}

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
		DetailPage(vm: DetailPageViewModel(id: "52928423562", urlString: "https://live.staticflickr.com/65535/52928423562_786dbf6d2f_b.jpg", title: "Photo 123456 details"))
    }
}
