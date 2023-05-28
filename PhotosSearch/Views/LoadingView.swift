//
//  LoadingView.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 22/05/2023.
//

import Foundation
import SwiftUI

/// loading view that include progress view and label
struct LoadingView: View {
	var tintColor: Color = .black
	var scaleSize: CGFloat = 1.0
	var text: String
	
	var body: some View {
		VStack(spacing: 10) {
			ProgressView()
				.scaleEffect(scaleSize, anchor: .center)
				.progressViewStyle(CircularProgressViewStyle(tint: tintColor))
			Text(text).font(.system(size: 15))
		}
	}
}

extension View {
	@ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
		switch shouldHide {
		case true: self.hidden()
		case false: self
		}
	}
}
