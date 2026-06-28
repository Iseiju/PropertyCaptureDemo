//
//  BasePropertyFormViewModel.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import CoreLocation
import Foundation
import UniformTypeIdentifiers

@Observable
class BasePropertyFormViewModel {

  var propertyName: String = ""
  var propertyType: String = ""
  var propertyAddress: String = ""
  var notes: String = ""

  var isActivityViewPresented: Bool = false

  var isSendButtonEnabled: Bool {
    return !propertyName.isBlank
      && !propertyType.isBlank
      && !propertyAddress.isBlank
      && !notes.isBlank
  }

  var activityItems: [Any] {
    let imagePreviewItem = ActivityItem(
      imageData: imageData,
      title: propertyName,
      subtitle: "📍 \(propertyType)"
    )

    let details = [
      "Name: \(propertyName)",
      "Type: \(propertyType)",
      "Address: \(propertyAddress)",
      "Notes: \(notes)"
    ]
      .joined(separator: "\n")

    return [imagePreviewItem, details]
  }

  let imageData: Data

  init(_ imageData: Data) {
    self.imageData = imageData
  }

  /// Override Functions
  /// Default implementation does nothing.
  /// Subclasses override if needed.
  func getReverseGeocodeInfo() async throws(AppError) {}
  func saveProperty() throws {}
}
