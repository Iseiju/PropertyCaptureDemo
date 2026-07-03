//
//  PropertyRepositoryMock.swift
//  PropertyCaptureDemoTests
//
//  Created by Kenneth James Uy on 6/27/26.
//

import Foundation
@testable import PropertyCaptureDemo

final class PropertyRepositoryMock: PropertyRepositoryProtocol {

  private var properties: [Property]

  init(properties: [Property]) {
    self.properties = properties
  }

  func getProperties() throws -> [Property] {
    return properties
  }

  func getProperty(for uuid: UUID) throws -> Property? {
    return properties.first { $0.id == uuid }
  }

  func insert(_ property: Property) throws {
    properties.append(property)
  }

  func save() throws {
    // The Property instance is already updated because it's a reference type.
  }
}
