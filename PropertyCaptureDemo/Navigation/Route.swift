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
  case propertyForm(_ imageData: Data, _ currentLocation: CLLocation)
}

extension Route {

  @ViewBuilder
  func destination(_ appContainer: AppContainer) -> some View {
    switch self {
    case .home:
      HomeFactory.makeHomeView(appContainer.propertyRepository)

    case .propertyForm(let imageData, let currentLocation):
      PropertyFormFactory
        .makePropertyFormView(
          imageData,
          currentLocation,
          appContainer.geocodingAPI,
          appContainer.propertyRepository
        )
    }
  }
}
