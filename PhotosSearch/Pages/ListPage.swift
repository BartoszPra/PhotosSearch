//
//  ContentView.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 22/05/2023.
//

import SwiftUI

struct ListPage: View {
	
	@StateObject var vm: ListPageViewModel
	
	var body: some View {
		NavigationStack  {
			ZStack {
				List {
					ForEach(vm.vmList) { image in
						ZStack {
							ImageCellView(imageViewModel: image).padding(2)
						}
					}.listRowSeparator(.hidden)
				}
				.navigationTitle(vm.title)
				.onViewDidLoad() {
					vm.getListData()
				}
				LoadingView(tintColor: .black, scaleSize: 1.0, text: "Loading data").hidden(!vm.isLoading)
			}.padding(0)
		}
		.searchable(text: $vm.searchText)
		.searchScopes($vm.searchScope, scopes: {
			Text("All").tag(ImagesSearchScope.all)
			Text("Username").tag(ImagesSearchScope.username)
			Text("Tags").tag(ImagesSearchScope.tags)
		})
		.onChange(of: vm.searchScope, perform: { newValue in
			if (!vm.searchText.isEmpty) {
				vm.reloadListData()
			}
		})
		.navigationViewStyle(StackNavigationViewStyle())
		.alert(isPresented: $vm.alertManager.shouldShowAlert ) {
			guard let alert = vm.alertManager.alert else { fatalError("Alert not available")
			}
			return Alert(alert)
		}
	}
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
		ListPage(vm: ListPageViewModel(title: "Photos", canNavigateToUser: true, dataUrl: ApiHelper.buildPhotosSearchRequestURL(text: "Home", searchType: .all)))
    }
}
