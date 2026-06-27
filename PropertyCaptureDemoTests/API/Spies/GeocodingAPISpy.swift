//
//  GeocodingAPISpy.swift
//  PropertyCaptureDemoTests
//
//  Created by Kenneth James Uy on 6/27/26.
//

import Foundation
@testable import PropertyCaptureDemo

final class GeocodingAPISpy: GeocodingAPIProtocol {

  enum Method: Equatable {
    case getReverseGeocodeInfo(_ latitude: Double, _ longitude: Double)
  }

  var called: [Method] = []

  func getReverseGeocodeInfo(
    _ latitude: Double, _ longitude: Double
  ) async throws -> PropertyCaptureDemo.ReverseGeocodeResponse {
    called.append(.getReverseGeocodeInfo(latitude, longitude))

    return ReverseGeocodeResponse.dummyData()
  }
}
