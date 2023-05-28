//
//  ListPageViewModelTests.swift
//  PhotosSearchTests
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import XCTest
@testable import PhotosSearch

final class ListPageViewModelTests: XCTestCase {

	var sut: ListPageViewModel!
	
	override func tearDownWithError() throws {
		sut = nil
	}

	func testCanCreateViewModel() throws {
		
		//setup
		sut = ListPageViewModel(title: "Photos", canNavigateToUser: true, dataUrl: ApiHelper.buildPhotosSearchRequestURL(text: "", searchType: .all), apiManager: NetworkManagerMock(isSuccess: true, errorType: NetworkError.noData), alertManager: AlertManager(), mainDispatchQueue: DispatchQueueMock())
		//assert
		XCTAssertNotNil(sut)
		XCTAssertTrue(sut.title == "Photos")
		XCTAssertNotNil(sut.url)
		XCTAssertEqual(sut.url, URL(string:	"https://api.flickr.com/services/rest?api_key=5f7483cb1ed57f1411919900611a6237&method=flickr.photos.getRecent&format=json&extras=url_t,url_l,tags&nojsoncallback=1&page=1"))
	}
	
	func testCanGetDetailDataProduceCorrectSuccessOutput() throws {
		
		///setup
		sut = ListPageViewModel(title: "Photos", canNavigateToUser: true, dataUrl: ApiHelper.buildPhotosSearchRequestURL(text: "", searchType: .all), apiManager: NetworkManagerMock(isSuccess: true, errorType: NetworkError.noData), alertManager: AlertManager(), mainDispatchQueue: DispatchQueueMock())
		/// act
		sut.getListData()
		///assert
		XCTAssertNotNil(sut.vmList)
		XCTAssertEqual(sut.searchText, "")
		XCTAssertEqual(sut.vmList.count, 3)
	}
	
	func testCanReloadDataProduceCorrectSuccessOutput() throws {
		
		///setup
		sut = ListPageViewModel(title: "Photos", canNavigateToUser: true, dataUrl: ApiHelper.buildPhotosSearchRequestURL(text: "", searchType: .all), apiManager: NetworkManagerMock(isSuccess: true, errorType: NetworkError.noData), alertManager: AlertManager(), mainDispatchQueue: DispatchQueueMock())
		/// act
		sut.reloadListData()
		///assert
		XCTAssertNotNil(sut.vmList)
		XCTAssertEqual(sut.searchText, "")
		XCTAssertEqual(sut.vmList.count, 3)
	}
	
	func testCangetGetDetailDataProduceCorrecOutputNoData() throws {
		
		///setup
		sut = ListPageViewModel(title: "Photos", canNavigateToUser: true, dataUrl: ApiHelper.buildPhotosSearchRequestURL(text: "", searchType: .all), apiManager: NetworkManagerMock(isSuccess: false, errorType: NetworkError.noData), alertManager: AlertManager(), mainDispatchQueue: DispatchQueueMock())
		/// act
		sut.getListData()
		///assert
		XCTAssertNotNil(sut)
		XCTAssertTrue(sut.vmList.isEmpty)
		XCTAssertEqual(sut.alertManager.shouldShowAlert, true)
		XCTAssertEqual(sut.alertManager.alert?.title, "Error")
		XCTAssertEqual(sut.alertManager.alert?.message, "Sorry there was a problem fetching data (No data)")
	}
	
	func testCangetGetDetailDataProduceOutputServerError() throws {
		
		///setup
		sut = ListPageViewModel(title: "Photos", canNavigateToUser: true, dataUrl: ApiHelper.buildPhotosSearchRequestURL(text: "", searchType: .all), apiManager: NetworkManagerMock(isSuccess: false, errorType: NetworkError.serverError(statusCode: 500)), alertManager: AlertManager(), mainDispatchQueue: DispatchQueueMock())
		/// act
		sut.getListData()
		///assert
		XCTAssertNotNil(sut)
		XCTAssertTrue(sut.vmList.isEmpty)
		XCTAssertEqual(sut.alertManager.shouldShowAlert, true)
		XCTAssertEqual(sut.alertManager.alert?.title, "Error")
		XCTAssertEqual(sut.alertManager.alert?.message, "Sorry there was a problem fetching data (Server Error:500)")
	}
	
	func testCangetGetDetailDataProduceOutputDecodingError() throws {
		
		///setup
		sut = ListPageViewModel(title: "Photos", canNavigateToUser: true, dataUrl: ApiHelper.buildPhotosSearchRequestURL(text: "", searchType: .all), apiManager: NetworkManagerMock(isSuccess: false, errorType: NetworkError.decodingError(NSError())), alertManager: AlertManager(), mainDispatchQueue: DispatchQueueMock())
		/// act
		sut.getListData()
		///assert
		XCTAssertNotNil(sut)
		XCTAssertTrue(sut.vmList.isEmpty)
		XCTAssertEqual(sut.alertManager.shouldShowAlert, true)
		XCTAssertEqual(sut.alertManager.alert?.title, "Error")
		XCTAssertEqual(sut.alertManager.alert?.message, "Sorry there was a problem fetching data (Decoding Error)")
	}
	
	func testCangetGetDetailDataProduceOutputDecodingTransportError() throws {
		
		///setup
		sut = ListPageViewModel(title: "Photos", canNavigateToUser: true, dataUrl: ApiHelper.buildPhotosSearchRequestURL(text: "", searchType: .all), apiManager: NetworkManagerMock(isSuccess: false, errorType: NetworkError.transportError(NSError())), alertManager: AlertManager(), mainDispatchQueue: DispatchQueueMock())
		/// act
		sut.getListData()
		///assert
		XCTAssertNotNil(sut)
		XCTAssertTrue(sut.vmList.isEmpty)
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
