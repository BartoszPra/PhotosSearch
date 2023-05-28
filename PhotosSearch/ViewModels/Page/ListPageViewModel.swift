//
//  ListViewModel.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import Foundation
import Combine

public class ListPageViewModel: BasePageViewModel {
	
	@Published var vmList = [ImageViewModel]()
	@Published var searchText = ""
	@Published var searchScope: ImagesSearchScope = .all
	private var disposeBag = Set<AnyCancellable>()
	var canNavigateToUser: Bool
	var isDebaunceInit: Bool = false
	let url: URL?
	
	init(title: String, canNavigateToUser: Bool, dataUrl: URL, apiManager: Networking = NetworkManager.shared, alertManager: AlertManager = AlertManager(), mainDispatchQueue: DispatchQueueType = DispatchQueue.main) {
		self.url = dataUrl
		self.canNavigateToUser = canNavigateToUser
		super.init(title: title, apiManager: apiManager, alertManager: alertManager, mainDispatchQueue: mainDispatchQueue)
		debounceTextChanges()
	}
	
	/// exposing getImagesFromApi
	func getListData() {
		if let url = url {
			getImagesFromApi(url: url)
		}
		
	}
	
	func reloadListData() {
		getImagesFromApi(url: ApiHelper.buildPhotosSearchRequestURL(text: searchText, searchType: self.searchScope))
	}
	
	/// using combine calls search after 1 sec when user stops typing
	private func debounceTextChanges() {
			$searchText
				// 1 second debounce
				.debounce(for: 1, scheduler: RunLoop.main)
				// Called after 2 seconds when text stops updating (stoped typing)
				.sink { [weak self] txt in
					if  let self = self, !self.isLoading, self.isDebaunceInit {
						self.getImagesFromApi(url: ApiHelper.buildPhotosSearchRequestURL(text: txt, searchType: self.searchScope))
					}
					self?.isDebaunceInit = true
				}
				.store(in: &disposeBag)
		}
	
	/**
	 Network call for photos data and on success proceed with calculation.

	 - Parameter recipient: The person being greeted.

	 - Throws: `Error that comes from network call`

	 - Returns: void - displays list data or shows error in alert.
	 */
	private func getImagesFromApi(url: URL) {
		isLoading = true
		self.vmList.removeAll()
		apiManager.fetchImages(url: url) { [weak self] res in
			switch res {
			case .success(let data):
				guard let self = self else {return}
				self.mainDispatchQueue.async {
					self.vmList = data.photos.photo.map({ photo in
						photo.toViewModel(canNavigateToUser: self.canNavigateToUser)
					})
					self.isLoading = false;
				}
			case .failure(let err):
				self?.mainDispatchQueue.async {
					self?.isLoading = false;
					self?.alertManager.showAlert(title: "Error", message: err.localizedDescription, primaryButtonText: "OK", primaryButtonAction: nil, secondaryButtonText: nil, secondaryButtonAction: nil)
				}
				return
			}
		}
	}
}
