//
//  GeocodingAPI.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import Foundation

enum GeocodingAPI: NetworkAPIProtocol {
  case getGeocodingInfo(_ latitude: Double, _ longitude: Double)

  var method: NetworkMethod {
    switch self {
    case .getGeocodingInfo:
      return .get
    }
  }

  var host: String {
    switch self {
    case .getGeocodingInfo:
      return "nominatim.openstreetmap.org"
    }
  }

  var endpoint: String {
    switch self {
    case .getGeocodingInfo:
      return "/reverse"
    }
  }

  var queryParams: [String : Any]? {
    switch self {
    case .getGeocodingInfo(let latitude, let longitude):
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

  func getGeocodingInfo(
    latitude: Double, longitude: Double
  ) async throws -> Geocoding {
    return try await request(
      api: GeocodingAPI.getGeocodingInfo(latitude, longitude),
      type: Geocoding.self
    )
  }
}
