//
//  DetailPageViewModelTests.swift
//  PhotosSearchTests
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import XCTest
@testable import PhotosSearch

final class DetailPageViewModelTests: XCTestCase {

	var sut: DetailPageViewModel!
	
	override func tearDownWithError() throws {
		sut = nil
	}

	func testCanCreateViewModel() throws {
		
		//setup
		sut = DetailPageViewModel(id: "qwerty", urlString: "https://www.google.co.uk", title: "Photo Details", apiManager: NetworkManagerMock(isSuccess: true, errorType: NetworkError.noData), alertManager: AlertManager(), mainDispatchQueue: DispatchQueueMock() )
		//assert
		XCTAssertNotNil(sut)
		XCTAssertTrue(sut.id == "qwerty")
		XCTAssertNotNil(sut.url)
		XCTAssertEqual(sut.url, URL(string: "https://www.google.co.uk"))
	}
	
	func testCangetGetDetailDataProduceCorrectSuccessOutput() throws {
		
		///setup
		sut = DetailPageViewModel(id: "qwerty", urlString: "https://www.google.co.uk", title: "Photo Details", apiManager: NetworkManagerMock(isSuccess: true, errorType: NetworkError.noData), alertManager: AlertManager(), mainDispatchQueue: DispatchQueueMock() )
		/// act
		sut.getGetDetailData()
		///assert
		XCTAssertNotNil(sut.imageDetailViewModel)
		XCTAssertEqual(sut.imageDetailViewModel?.tags.count, 3)
		XCTAssertEqual(sut.imageDetailViewModel?.ownerId, "12")
		XCTAssertEqual(sut.imageDetailViewModel?.ownerUserName, "BP")
		XCTAssertEqual(sut.imageDetailViewModel?.description, "sample photo description")
		XCTAssertEqual(sut.imageDetailViewModel?.photoTitle, "Sample Photo")
	}
	
	func testCangetGetDetailDataProduceCorrecOutputNoData() throws {
		
		///setup
		sut = DetailPageViewModel(id: "qwerty", urlString: "https://www.google.co.uk", title: "Photo Details", apiManager: NetworkManagerMock(isSuccess: false, errorType: NetworkError.noData), alertManager: AlertManager(), mainDispatchQueue: DispatchQueueMock() )
		/// act
		sut.getGetDetailData()
		///assert
		XCTAssertNotNil(sut)
		XCTAssertNil(sut.imageDetailViewModel)
		XCTAssertEqual(sut.alertManager.shouldShowAlert, true)
		XCTAssertEqual(sut.alertManager.alert?.title, "Error")
		XCTAssertEqual(sut.alertManager.alert?.message, "Sorry there was a problem fetching data (No data)")
	}
	
	func testCangetGetDetailDataProduceOutputServerError() throws {
		
		///setup
		sut = DetailPageViewModel(id: "qwerty", urlString: "https://www.google.co.uk", title: "Photo Details", apiManager: NetworkManagerMock(isSuccess: false, errorType: NetworkError.serverError(statusCode: 500)), alertManager: AlertManager(), mainDispatchQueue: DispatchQueueMock() )
		/// act
		sut.getGetDetailData()
		///assert
		XCTAssertNotNil(sut)
		XCTAssertNil(sut.imageDetailViewModel)
		XCTAssertEqual(sut.alertManager.shouldShowAlert, true)
		XCTAssertEqual(sut.alertManager.alert?.title, "Error")
		XCTAssertEqual(sut.alertManager.alert?.message, "Sorry there was a problem fetching data (Server Error:500)")
	}
	
	func testCangetGetDetailDataProduceOutputDecodingError() throws {
		
		///setup
		sut = DetailPageViewModel(id: "qwerty", urlString: "https://www.google.co.uk", title: "Photo Details", apiManager: NetworkManagerMock(isSuccess: false, errorType: NetworkError.decodingError(NSError())), alertManager: AlertManager(), mainDispatchQueue: DispatchQueueMock() )
		/// act
		sut.getGetDetailData()
		///assert
		XCTAssertNotNil(sut)
		XCTAssertNil(sut.imageDetailViewModel)
		XCTAssertEqual(sut.alertManager.shouldShowAlert, true)
		XCTAssertEqual(sut.alertManager.alert?.title, "Error")
		XCTAssertEqual(sut.alertManager.alert?.message, "Sorry there was a problem fetching data (Decoding Error)")
	}
	
	func testCangetGetDetailDataProduceOutputTransportError() throws {
		
		///setup
		sut = DetailPageViewModel(id: "qwerty", urlString: "https://www.google.co.uk", title: "Photo Details", apiManager: NetworkManagerMock(isSuccess: false, errorType: NetworkError.transportError(NSError())), alertManager: AlertManager(), mainDispatchQueue: DispatchQueueMock() )
		/// act
		sut.getGetDetailData()
		///assert
		XCTAssertNotNil(sut)
		XCTAssertNil(sut.imageDetailViewModel)
		XCTAssertEqual(sut.alertManager.shouldShowAlert, true)
		XCTAssertEqual(sut.alertManager.alert?.title, "Error")
		XCTAssertEqual(sut.alertManager.alert?.message, "Sorry there was a problem fetching data (Transport Error)")
	}
	
	func testPerformanceExample() throws {
		// This is an example of a performance test case.
		self.measure {
			// Put the code you want to measure the time of here.
		}
	}
}
