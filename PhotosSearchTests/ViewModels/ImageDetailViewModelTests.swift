//
//  ListViewModelTests.swift
//  PhotosSearchTests
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import XCTest
@testable import PhotosSearch

final class ImageDetailViewModelTests: XCTestCase {

	var sut: ImageDetailViewModel!

    override func tearDownWithError() throws {
        sut = nil
    }

    func testCanCreateCorrectOutput() throws {
		///setup
		sut = ImageDetailViewModel(imageDetails: ImageDetails.sample)
		
		///assert
		XCTAssertNotNil(sut)
		XCTAssertEqual(sut.id, "12345")
		XCTAssertEqual(sut.photoTitle, "Sample Photo")
		XCTAssertEqual(sut.description, "sample photo description")
		XCTAssertEqual(sut.ownerId, "12")
		XCTAssertEqual(sut.ownerUserName, "BP")
		XCTAssertEqual(sut.tags.count, 3)
		
    }
	
	
	func testOutputWithNull() {
		let model = ImageDetails(id: "12345", secret: "secret", server: "1234", farm: 66, dateuploaded: "07.04.1999", owner: Owner(nsid: nil, username: nil), title: Comments(_content:nil), description: Comments(_content:nil), comments: Comments(_content: nil), tags: Tags(tag:[Tag(id: "1", _content: "sample"), Tag(id: "2", _content: "test"),Tag(id: "3", _content: "app")]))
		
		sut = ImageDetailViewModel(imageDetails: model)
		
		///assert
		XCTAssertNotNil(sut)
		XCTAssertEqual(sut.id, "12345")
		XCTAssertEqual(sut.photoTitle, "No title")
		XCTAssertEqual(sut.description, "No description")
		XCTAssertEqual(sut.ownerId, "No user id")
		XCTAssertEqual(sut.ownerUserName, "No username")
		XCTAssertEqual(sut.tags.count, 3)
	}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
