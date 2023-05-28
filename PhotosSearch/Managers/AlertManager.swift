//
//  AlertManager.swift
//  PhotosSearch
//
//  Created by Bartosz Prazmo on 27/05/2023.
//

import Foundation
import SwiftUI

/// Class to manage creation of the alert
class AlertManager {

	/// flag to change the visibility of the alert
	@Published var shouldShowAlert = false

	var alert: Alert? = nil {
		didSet {
			shouldShowAlert = alert != nil
		}
	}
	
	/// internal struct to represent alert
	struct Alert {
		var title: String
		var message: String
		var primaryButtonText: String
		var primaryButtonAction: (() -> Void)?
		var secondaryButtonText: String?
		var secondaryButtonAction: (() -> Void)?
	}
	
	/**
	Fetching generic data from api .
		 - Parameters:
			- title: Text that is alert title
			- message: completiion handler with Generic Succees Result or Network Error failure
		 - Returns: void
	 */
	func showAlert(title: String, message: String, primaryButtonText: String, primaryButtonAction: (() -> Void)?, secondaryButtonText: String?, secondaryButtonAction: (() -> Void)?) {
		alert = AlertManager.Alert(
			title: title,
			message: message,
			primaryButtonText: primaryButtonText,
			primaryButtonAction: primaryButtonAction,
			secondaryButtonText: secondaryButtonText,
			secondaryButtonAction: secondaryButtonAction
		)
	}
}

// Alert extension to create alert from alertManager.alert
extension Alert {
	init(_ alert: AlertManager.Alert) {
		if let sbt = alert.secondaryButtonText {
			self.init(title: Text(alert.title),
					  message: Text(alert.message),
					  primaryButton: .default(Text(alert.primaryButtonText),
											  action: alert.primaryButtonAction),
					  secondaryButton: .cancel(Text(sbt))
			)
		} else {
			self.init(title: Text(alert.title),
					  message: Text(alert.message),
					  dismissButton: .default(Text(alert.primaryButtonText)))
		}
	}
}
