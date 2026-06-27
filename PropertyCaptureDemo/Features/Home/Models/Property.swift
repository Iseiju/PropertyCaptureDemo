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

  var name: String
  var type: String
  var address: String
  var notes: String

  init(
    id: UUID = UUID(),
    name: String,
    type: String,
    address: String,
    notes: String
  ) {
    self.id = id
    self.name = name
    self.type = type
    self.address = address
    self.notes = notes
  }
}
