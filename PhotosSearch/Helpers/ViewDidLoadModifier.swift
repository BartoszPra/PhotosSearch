//
//  ViewDidLoadModifier.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import Foundation
import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
	@State private var viewDidLoad = false
	let action: (() -> Void)?
	
	func body(content: Content) -> some View {
		content
		// Task is the same like onAppear, but works with async tasks.
		// also it cancels the task when the view disappears.
			.task {
				if viewDidLoad == false {
					viewDidLoad = true
					action?()
				}
			}
	}
}

extension View {
	func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
		self.modifier(ViewDidLoadModifier(action: action))
	}
}
