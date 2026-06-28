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
    property: Property,
    propertyRepository: PropertyRepositoryProtocol
  ) -> some View {
    let viewModel = PropertyDetailsViewModel(
      property: property, propertyRepository: propertyRepository
    )

    return PropertyFormView(viewModel)
  }

  static func makePropertyFormView(
    imageData: Data,
    currentLocation: CLLocation,
    geocodingAPI: GeocodingAPIProtocol,
    propertyRepository: PropertyRepositoryProtocol
  ) -> some View {
    let viewModel = PropertyCaptureViewModel(
      imageData: imageData,
      currentLocation: currentLocation,
      geocodingAPI: geocodingAPI,
      propertyRepository: propertyRepository
    )

    return PropertyFormView(viewModel)
  }
}
