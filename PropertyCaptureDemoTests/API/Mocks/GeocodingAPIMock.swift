//
//  GeocodingAPIMock.swift
//  PropertyCaptureDemoTests
//
//  Created by Kenneth James Uy on 6/27/26.
//

import Foundation
@testable import PropertyCaptureDemo

final class GeocodingAPIMock: GeocodingAPIProtocol {

  var getReverseGeocodeInfoResult: Result<ReverseGeocodeResponse, Error>?

  func getReverseGeocodeInfo(
    _ latitude: Double, _ longitude: Double
  ) async throws -> ReverseGeocodeResponse {
    switch getReverseGeocodeInfoResult {
    case .success(let data):
      return data

    case .failure(let error):
      throw error

    case .none:
//      throw DecodingError.dataCorrupted
//      throw custom error
    }
  }
}
