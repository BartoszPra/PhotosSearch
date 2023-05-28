//
//  DispatchQueueMock.swift
//  PhotosSearchTests
//
//  Created by Bartosz Prazmo on 27/05/2023.
//
import Foundation
import UIKit
@testable import PhotosSearch

final class DispatchQueueMock: DispatchQueueType {
	
	func async(execute work: @escaping @convention(block) () -> Void) {
		work()
	}
}
