//
//  BasePageViewModel.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import Foundation

public class BasePageViewModel: ObservableObject {
	
	@Published var isLoading: Bool = false
	// class that manages the network calls
	var apiManager: Networking
	// wrapper around dispatch queue for testability
	var mainDispatchQueue: DispatchQueueType
	// class that manages alerts
	var alertManager: AlertManager
	// Page title
	var title: String
	
	init(title: String, apiManager: Networking, alertManager: AlertManager, mainDispatchQueue: DispatchQueueType) {
		self.title = title
		self.apiManager = apiManager
		self.alertManager = alertManager
		self.mainDispatchQueue = mainDispatchQueue
	}
}

