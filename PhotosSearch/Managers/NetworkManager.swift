//
//  NetworkManager.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 22/05/2023.
//

import Foundation
import UIKit

/// protocol to expose Network Manager
protocol Networking {
	func fetchImages(url: URL, completion: @escaping (Result<Images, NetworkError>) -> Void)
	func fetchDetails(text: String, completion: @escaping (Result<ImageDetail, NetworkError>) -> Void)
}

/// Class to manage api calls.
class NetworkManager: Networking {
	
	/// singleton instance
	static let shared = NetworkManager()
	
	func fetchImages(url: URL, completion: @escaping (Result<Images, NetworkError>) -> Void) {
		fetchGenericJSONData(url: url, completion: completion)
	}
	
	func fetchDetails(text: String, completion: @escaping (Result<ImageDetail, NetworkError>) -> Void) {
		fetchGenericJSONData(url: ApiHelper.buildPhotoDetailUrl(photoId: text), completion: completion)
	}
	
	/**
	Fetching generic data from api .
		 - Parameters:
			- urlString: The lis of planes to store
			- completion: completiion handler with Generic Succees Result or Network Error failure
		 - Returns: void
	 */
	private func fetchGenericJSONData<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {

		URLSession.shared.dataTask(with: url) { data, response, error in
			if let networkError = NetworkError(data: data, response: response, error: error) {
				completion(.failure(networkError))
			}
			do {
				if let dta = data {
					let obj = try JSONDecoder().decode(T.self, from: dta)
					completion(.success(obj))
				} else {
					completion(.failure(.noData))
				}
			} catch (let err){
				completion(.failure(.decodingError(err)))
			}
		}.resume()
	}
}
