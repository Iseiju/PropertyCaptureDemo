//
//  PropertyRepository.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/27/26.
//

import Foundation
import SwiftData

final class PropertyRepository: PropertyRepositoryProtocol {

  private let modelContext: ModelContext

  init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }
}

// MARK: Persistence

extension PropertyRepository {

  func getProperties() async throws -> [Property] {
    let descriptor = FetchDescriptor<Property>()

    return try modelContext.fetch(descriptor)
  }

  func save(_ property: Property) throws {
    modelContext.insert(property)

    try modelContext.save()
  }
}
