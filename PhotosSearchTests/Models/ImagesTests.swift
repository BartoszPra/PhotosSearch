//
//  ImagesTests.swift
//  PhotosSearchTests
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import XCTest
@testable import PhotosSearch

final class ImagesTests: XCTestCase {
	
	var sut: Images!
	
	override func tearDownWithError() throws {
		sut = nil
	}

	func testCanCreateModel() throws {
		
		//setup
		sut = Images(photos: Photos(page: 1, pages: 10, perpage: 100, total: 1000, photo: [Photo.sample, Photo.sample, Photo.sample]), stat: "OK")
		//assert
		XCTAssertNotNil(sut)
		XCTAssertEqual(sut.photos.photo.count, 3)
		XCTAssertEqual(sut.photos.photo.first?.id, "BartoszPhotoId")
		XCTAssertEqual(sut.photos.photo.first?.title, "Sample Photo")
		XCTAssertEqual(sut.photos.photo.first?.tags, "tagg")
		XCTAssertEqual(sut.photos.photo.first?.owner, "Bartosz")
		XCTAssertEqual(sut.photos.photo.first?.url_l, "https://live.staticflickr.com/65535/52917340364_82faa5ed15_c.jpg")
		XCTAssertEqual(sut.photos.photo.first?.url_t, "https://live.staticflickr.com/65535/52917340364_82faa5ed15_b.jpg")
	}
	
	func testCanCreateViewModel() throws {
		
		//setup
		sut = Images(photos: Photos(page: 1, pages: 10, perpage: 100, total: 1000, photo: [Photo.sample, Photo.sample, Photo.sample]), stat: "OK")
		
		//act
		let viewModel = sut.photos.photo.first?.toViewModel(canNavigateToUser: true)
		
		//assert
		XCTAssertNotNil(viewModel)
		XCTAssertEqual(viewModel?.tagsString.count, 4)
		XCTAssertEqual(viewModel?.userId, "Bartosz")
		XCTAssertEqual(viewModel?.photoId, "BartoszPhotoId")
		XCTAssertEqual(viewModel?.photoTitle, "Sample Photo")
		XCTAssertEqual(viewModel?.tagsString, "tagg")
		XCTAssertEqual(viewModel?.thumbnailPhotoImageUrl, URL(string: "https://live.staticflickr.com/65535/52917340364_82faa5ed15_b.jpg"))
		XCTAssertEqual(viewModel?.userIconUrl, URL(string: "https://farm66.staticflickr.com/65535/buddyicons/Bartosz.jpg"))
		XCTAssertEqual(viewModel?.largeImageUrlString, "https://live.staticflickr.com/65535/52917340364_82faa5ed15_c.jpg")
	}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
