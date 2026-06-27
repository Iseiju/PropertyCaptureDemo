//
//  Property.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/27/26.
//

import Foundation
import SwiftData

@Model
final class Property {

  @Attribute(.unique)
  var id: UUID

  @Attribute(.externalStorage)
  var imageData: Data

  var name: String
  var type: String
  var address: String
  var notes: String

  init(
    id: UUID = UUID(),
    imageData: Data,
    name: String,
    type: String,
    address: String,
    notes: String
  ) {
    self.id = id
    self.imageData = imageData
    self.name = name
    self.type = type
    self.address = address
    self.notes = notes
  }
}

// MARK: Dummy Data

extension Property {

  static func dummyProperty() -> Property {
    return Property(
      imageData: Data(repeating: 0xFF, count: 1024),
      name: "Sample Name",
      type: "Sample Type",
      address: "Sample Address",
      notes: "Sample Notes"
    )
  }

  static func dummyProperties() -> [Property] {
    return [dummyProperty(), dummyProperty(), dummyProperty()]
  }
}
