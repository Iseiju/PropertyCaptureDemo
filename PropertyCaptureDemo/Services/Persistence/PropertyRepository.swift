//
//  PropertyRepository.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/27/26.
//

import Foundation
import SwiftData

final class PropertyRepository {

  private let modelContext: ModelContext

  init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }
}

extension PropertyRepository {

  func getProperties() async throws -> [Property] {
    let descriptor = FetchDescriptor<Property>()

    return try modelContext.fetch(descriptor)
  }

  func saveProperty(_ property: Property) throws {
    modelContext.insert(property)

    try modelContext.save()
  }
}
