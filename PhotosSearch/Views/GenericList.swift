//
//  GenericList.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import SwiftUI

//class ListtViewModel<T> where T:Identifiable {
//	var items: [T] {get set}
//	var title: String {get set}
//	var searchText: String {get set}
//	func getListData()
//}
//
//struct GenericList<T: ListtViewModel<U: ImageViewModel>,  RowContent: View>: View {
//
//	// 2
//	var vm: T
//	private let rowContent: (T) -> RowContent
//
//	// 3
//	public init(_ items: T, @ViewBuilder rowContent: @escaping (T) -> RowContent) {
//		self.vm = items
//		self.rowContent = rowContent
//	}
//
//	// 4
////	var body: some View {
////		List(items, rowContent: rowContent)
////	}
//	
//	var body: some View {
//		NavigationStack  {
//			ZStack {
//				List(vm.items, rowContent: rowContent)
//				.navigationTitle(vm.title)
//				.onViewDidLoad() {
//					vm.getListData()
//				}
//				LoadingView(tintColor: .black, scaleSize: 1.0, text: "Loading data").hidden(!vm.isLoading)
//			}.padding(0)
//		}.searchable(text: vm.searchText)
//		 .navigationViewStyle(StackNavigationViewStyle())
//			
//
//		.alert(isPresented: vm.alertManager.shouldShowAlert ) {
//			guard let alert = vm.alertManager.alert else { fatalError("Alert not available")
//			}
//			return Alert(alert)
//		}
//	}
//}

//struct GenericList_Previews: PreviewProvider {
//    static var previews: some View {
//		GenericList([Photo]()) { photo in
//			<#code#>
//		}
//    }
//}


