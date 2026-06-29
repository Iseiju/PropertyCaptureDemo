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

  let locationService: LocationServiceProtocol
  let cameraService: CameraServiceProtocol

  let propertyRepository: PropertyRepositoryProtocol
  let geocodingAPI: GeocodingAPIProtocol

  init() {
    locationService = LocationService()
    cameraService = CameraService()

    let networkService = NetworkService()
    geocodingAPI = networkService

    let schema = Schema([Property.self])
    let configuration = ModelConfiguration(
      schema: schema, isStoredInMemoryOnly: false
    )

    do {
      let container = try ModelContainer(
        for: schema, configurations: configuration
      )

      modelContainer = container
      modelContext = container.mainContext

      propertyRepository = PropertyRepository(
        modelContext: container.mainContext
      )
    } catch {
      fatalError("Could not initialize model container: \(error.localizedDescription)")
    }
  }
}
