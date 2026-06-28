//
//  AppContainer.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/27/26.
//

import Foundation
import SwiftData

struct AppContainer {

  let modelContainer: ModelContainer
  let modelContext: ModelContext

  let locationService: LocationService

  let propertyRepository: PropertyRepositoryProtocol
  let geocodingAPI: GeocodingAPIProtocol

  init() {
    do {
      let schema = Schema([Property.self])
      let configuration = ModelConfiguration(
        schema: schema, isStoredInMemoryOnly: false
      )
      let container = try ModelContainer(
        for: schema, configurations: configuration
      )

      modelContainer = container
      modelContext = container.mainContext

      locationService = LocationService()

      propertyRepository = PropertyRepository(
        modelContext: container.mainContext
      )

      let networkService = NetworkService()
      geocodingAPI = networkService
    } catch {
      fatalError("Could not initialize model container: \(error.localizedDescription)")
    }
  }
}
