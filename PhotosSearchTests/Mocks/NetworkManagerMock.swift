//
//  NetworkManagerMock.swift
//  PhotosSearchTests
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import Foundation
@testable import PhotosSearch

class NetworkManagerMock: Networking {
	
	var isSuccess: Bool
	var errorType: NetworkError
	
	init(isSuccess: Bool, errorType: NetworkError) {
		self.isSuccess = isSuccess
		self.errorType = errorType
	}
	
	func fetchImages(url: URL, completion: @escaping (Result<Images, NetworkError>) -> Void) {
		if isSuccess{
			completion(Result.success(Images(photos: Photos(page: 1, pages: 10, perpage: 100, total: 1000, photo: [Photo.sample, Photo.sample, Photo.sample]), stat: "OK")))
		} else {
			var err: NetworkError!
			
			switch errorType {
			case .transportError(_):
				err = NetworkError.transportError(NSError())
			case .serverError(statusCode: _):
				err = NetworkError.serverError(statusCode: 500)
			case .noData:
				err = NetworkError.noData
			case .decodingError(_):
				err = NetworkError.decodingError(NSError())
			}
			
			completion(Result.failure(err))
		}
	}
	
	func fetchDetails(text: String, completion: @escaping (Result<ImageDetail, NetworkError>) -> Void) {
		if isSuccess{
			completion(Result.success(ImageDetail(photo: ImageDetails.sample, stat: "OK")))
		} else {
			var err: NetworkError!
			switch errorType {
			case .transportError(_):
				err = NetworkError.transportError(NSError())
			case .serverError(statusCode: _):
				err = NetworkError.serverError(statusCode: 500)
			case .noData:
				err = NetworkError.noData
			case .decodingError(_):
				err = NetworkError.decodingError(NSError())
			}
			
			completion(Result.failure(err))
		}
	}
}
