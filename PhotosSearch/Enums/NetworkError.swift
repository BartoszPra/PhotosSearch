//
//  NetworkError.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import Foundation

/// error enum to better represent network errors
enum NetworkError: Error {
	
	case transportError(Error)
	case serverError(statusCode: Int)
	case noData
	case decodingError(Error)
}

extension NetworkError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .noData:
			return NSLocalizedString("Sorry there was a problem fetching data (No data)", comment: "No Data")
		case .transportError(_):
			return NSLocalizedString("Sorry there was a problem fetching data (Transport Error)", comment: "Transport Error")
		case .serverError(statusCode: let statusCode):
			return NSLocalizedString("Sorry there was a problem fetching data (Server Error:\(statusCode.description))", comment: "Server Error")
		case .decodingError(_):
			return NSLocalizedString("Sorry there was a problem fetching data (Decoding Error)", comment: "Decoding Error")
		}
	}
}

extension NetworkError {
	
	init?(data: Data?, response: URLResponse?, error: Error?) {
		if let error = error {
			self = .transportError(error)
			return
		}

		if let response = response as? HTTPURLResponse,
			!(200...299).contains(response.statusCode) {
			self = .serverError(statusCode: response.statusCode)
			return
		}
		
		if data == nil {
			self = .noData
			return
		}
		
		return nil
	}
}
