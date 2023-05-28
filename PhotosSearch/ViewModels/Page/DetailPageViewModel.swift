//
//  DetailViewModel.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import Foundation
import Combine


public class DetailPageViewModel: BasePageViewModel {
	
	@Published var imageDetailViewModel: ImageDetailViewModel?
	let id: String
	var url: URL?
	
	init(id: String, urlString: String?, title: String, apiManager: Networking = NetworkManager.shared, alertManager: AlertManager = AlertManager(), mainDispatchQueue: DispatchQueueType = DispatchQueue.main) {
		self.id = id
		if let str = urlString {
			url = URL(string: str)
		}
		super.init(title: title, apiManager: apiManager, alertManager: alertManager, mainDispatchQueue: mainDispatchQueue)
	}

	/// exposing getDataFromApi
	func getGetDetailData() {
		getDataFromApi(text: id)
	}

	/**
	 Network call for photos data and on success proceed with calculation.

	 - Parameter recipient: The person being greeted.

	 - Throws: `Error that comes from network call`

	 - Returns: void - displays list data or shows error in alert.
	 */
	private func getDataFromApi(text: String) {
		isLoading = true
		apiManager.fetchDetails(text: text) { [weak self] res in
			switch res {
			case .success(let data):
				guard let self = self else {return}
				self.mainDispatchQueue.async {
					self.imageDetailViewModel = ImageDetailViewModel(imageDetails: data.photo)
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
