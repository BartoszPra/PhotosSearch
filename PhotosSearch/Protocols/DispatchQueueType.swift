//
//  DispatchQueueType.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import Foundation

/// protocol to make the DispatchQueue testable
protocol DispatchQueueType {
	func async(execute work: @escaping @convention(block) () -> Void)
}

extension DispatchQueue: DispatchQueueType {
	func async(execute work: @escaping @convention(block) () -> Void) {
		async(group: nil, qos: .unspecified, flags: [], execute: work)
	}
}
