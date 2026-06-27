//
//  GeocodingAPI.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import Foundation

enum GeocodingAPI: NetworkAPIProtocol {
  case getReverseGeocodeInfo(_ latitude: Double, _ longitude: Double)

  var method: NetworkMethod {
    switch self {
    case .getReverseGeocodeInfo:
      return .get
    }
  }

  var host: String {
    switch self {
    case .getReverseGeocodeInfo:
      return "nominatim.openstreetmap.org"
    }
  }

  var endpoint: String {
    switch self {
    case .getReverseGeocodeInfo:
      return "/reverse"
    }
  }

  var queryParams: [String : Any]? {
    switch self {
    case .getReverseGeocodeInfo(let latitude, let longitude):
      return [
        "lat" : latitude,
        "lon" : longitude,
        "format" : "json"
      ]
    }
  }
}

// MARK: Implementation

extension NetworkService: GeocodingAPIProtocol {

  func getReverseGeocodeInfo(
    _ latitude: Double, _ longitude: Double
  ) async throws(AppError)  -> ReverseGeocodeResponse {
    return try await request(
      api: GeocodingAPI.getReverseGeocodeInfo(latitude, longitude),
      type: ReverseGeocodeResponse.self
    )
  }
}
