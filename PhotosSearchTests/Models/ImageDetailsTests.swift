//
//  ImageDetailTests.swift
//  PhotosSearchTests
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import XCTest
@testable import PhotosSearch

final class ImageDetailsTests: XCTestCase {

	var sut: ImageDetails!
	
	override func tearDownWithError() throws {
		sut = nil
	}

	func testCanCreateModel() throws {
		
		//setup
		sut = ImageDetails.sample
		//assert
		XCTAssertNotNil(sut)
		XCTAssertEqual(sut.id, "12345")
		XCTAssertEqual(sut.title._content, "Sample Photo")
		XCTAssertEqual(sut.owner.username, "BP")
		XCTAssertEqual(sut.owner.nsid, "12")
		XCTAssertEqual(sut.description._content, "sample photo description")
		XCTAssertEqual(sut.tags.tag.count, 3)
		
	}
	
	func testCanCreateViewModel() throws {
		
		//setup
		sut = ImageDetails.sample
		
		//act
		let viewModel = sut.toViewModel(canNavigateToUser: true)
		
		//assert
		XCTAssertNotNil(viewModel)
		XCTAssertEqual(viewModel.id, "12345")
		XCTAssertEqual(viewModel.ownerId, "12")
		XCTAssertEqual(viewModel.photoTitle, "Sample Photo")
		XCTAssertEqual(viewModel.tags.count, 3)
		XCTAssertEqual(viewModel.ownerUserName, "BP")
		XCTAssertEqual(viewModel.description, "sample photo description")
	}

	func testPerformanceExample() throws {
		// This is an example of a performance test case.
		self.measure {
			// Put the code you want to measure the time of here.
		}
	}

}
