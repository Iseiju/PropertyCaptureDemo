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

  var imageURL: String
  var name: String
  var type: String
  var address: String
  var notes: String

  init(
    id: UUID = UUID(),
    imageURL: String,
    name: String,
    type: String,
    address: String,
    notes: String
  ) {
    self.id = id
    self.imageURL = imageURL
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
      imageURL: "",
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
