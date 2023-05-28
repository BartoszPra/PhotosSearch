//
//  PhotosSearchApp.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 22/05/2023.
//

import SwiftUI

@main
struct PhotosSearchApp: App {
    var body: some Scene {
        WindowGroup {
			ListPage(vm: ListPageViewModel(title: "Photos", canNavigateToUser: true, dataUrl: ApiHelper.buildPhotosSearchRequestURL(text: "", searchType: .all)))
        }
    }
}
