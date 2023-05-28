//
//  ApiHelperTests.swift
//  PhotosSearchTests
//
//  Created by Bartosz Prazmo on 28/05/2023.
//

import XCTest
@testable import PhotosSearch

final class ApiHelperTests: XCTestCase {
	
	var sut: URL!

    override func tearDownWithError() throws {
       sut = nil
    }
	
	func testCanBuildImagesSearchUrlAllEmpty() throws {
		//arrange
		sut = ApiHelper.buildPhotosSearchRequestURL(text: "", searchType: .all)
		//assert
		XCTAssertEqual(sut, URL(string:"https://api.flickr.com/services/rest?api_key=5f7483cb1ed57f1411919900611a6237&method=flickr.photos.getRecent&format=json&extras=url_t,url_l,tags&nojsoncallback=1&page=1"))
	}

    func testCanBuildImagesSearchUrlAll() throws {
		//arrange
		sut = ApiHelper.buildPhotosSearchRequestURL(text: "dog", searchType: .all)
		//assert
		XCTAssertEqual(sut, URL(string: "https://api.flickr.com/services/rest?api_key=5f7483cb1ed57f1411919900611a6237&method=flickr.photos.search&format=json&text=dog&extras=url_t,url_l,tags&nojsoncallback=1&page=1"))
    }
	
	func testCanBuildImagesSearchUrlTags() throws {
		//arrange
		sut = ApiHelper.buildPhotosSearchRequestURL(text: "dog", searchType: .tags)
		//assert
		XCTAssertEqual(sut, URL(string: "https://api.flickr.com/services/rest?api_key=5f7483cb1ed57f1411919900611a6237&method=flickr.photos.search&format=json&tags=dog&extras=url_t,url_l,tags&nojsoncallback=1&page=1"))
	}
	
	func testCanBuildImagesSearchUrlUsername() throws {
		//arrange
		sut = ApiHelper.buildPhotosSearchRequestURL(text: "dog", searchType: .username)
		//assert
		XCTAssertEqual(sut, URL(string: "https://api.flickr.com/services/rest?api_key=5f7483cb1ed57f1411919900611a6237&method=flickr.photos.search&format=json&text=dog&extras=url_t,url_l,tags&nojsoncallback=1&page=1"))
	}
	
	func testCanBuildUserImageSearchUrl() throws {
		//arrange
		sut = ApiHelper.buildUserIconUrl(iconFarm: 123, iconServer: "6699", nsId: "1234")
		//assert
		XCTAssertEqual(sut, URL(string: "https://farm123.staticflickr.com/6699/buddyicons/1234.jpg"))
	}
	
	func testCanBuildImageDetailSearchUrl() throws {
		//arrange
		sut = ApiHelper.buildPhotoDetailUrl(photoId: "1234")
		//assert
		XCTAssertEqual(sut, URL(string: "https://flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=5f7483cb1ed57f1411919900611a6237&photo_id=1234&format=json&nojsoncallback=1"))
	}
	
	func testCanBuildUserImagesUrl() throws {
		//arrange
		sut = ApiHelper.buildUserPhotosUrl(userId: "1234")
		//assert
		XCTAssertEqual(sut, URL(string: "https://flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=5f7483cb1ed57f1411919900611a6237&user_id=1234&extras=url_t,tags&format=json&nojsoncallback=1"))
	}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
