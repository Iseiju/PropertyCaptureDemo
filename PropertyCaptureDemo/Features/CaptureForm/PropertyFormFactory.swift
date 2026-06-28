//
//  PropertyFormFactory.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import CoreLocation
import SwiftUI

enum PropertyFormFactory {

  static func makePropertyFormView(
    _ property: Property
  ) -> some View {
    let viewModel = PropertyDetailsViewModel(property)

    return PropertyFormView(viewModel)
  }

  static func makePropertyFormView(
    imageData: Data,
    currentLocation: CLLocation,
    geocodingAPI: GeocodingAPIProtocol,
    propertyRepository: PropertyRepositoryProtocol
  ) -> some View {
    let viewModel = PropertyCaptureViewModel(
      imageData,
      currentLocation,
      geocodingAPI,
      propertyRepository
    )

    return PropertyFormView(viewModel)
  }
}
