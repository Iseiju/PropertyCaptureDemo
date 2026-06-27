//
//  PropertyRepositoryMock.swift
//  PropertyCaptureDemoTests
//
//  Created by Kenneth James Uy on 6/27/26.
//

import Foundation
@testable import PropertyCaptureDemo

final class PropertyRepositoryMock: PropertyRepositoryProtocol {

  func getProperties() async throws -> [Property] {
    return Property.dummyProperties()
  }

  func getProperty(for uuid: UUID) throws -> Property? {
    return Property.dummyProperty()
  }

  func save(_ property: Property) throws {
    print("DUMMY SAVE")
  }
}
