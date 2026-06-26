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
    _ imageData: Data,
    _ currentLocation: CLLocation,
    _ geocodingAPI: GeocodingAPIProtocol = NetworkService.shared
  ) -> some View {
    return PropertyFormView(
      PropertyFormViewModel(imageData, currentLocation, geocodingAPI)
    )
  }
}
