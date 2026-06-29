//
//  Route.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import CoreLocation
import SwiftUI

enum Route: Hashable {
  case home
  case propertyDetails(_ property: Property)
  case propertyForm(imageData: Data, currentLocation: CLLocation)
}

extension Route {

  @ViewBuilder
  func destination(_ appContainer: AppContainer) -> some View {
    switch self {
    case .home:
      HomeFactory
        .makeHomeView(
          locationService: appContainer.locationService,
          cameraService: appContainer.cameraService,
          propertyRepository: appContainer.propertyRepository
        )

    case .propertyDetails(let property):
      PropertyFormFactory
        .makePropertyFormView(
          property: property,
          propertyRepository: appContainer.propertyRepository
        )

    case .propertyForm(let imageData, let currentLocation):
      PropertyFormFactory
        .makePropertyFormView(
          imageData: imageData,
          currentLocation: currentLocation,
          geocodingAPI: appContainer.geocodingAPI,
          propertyRepository: appContainer.propertyRepository
        )
    }
  }
}
