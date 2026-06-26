//
//  GeocodingAPIProtocol.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/27/26.
//

import Foundation

protocol GeocodingAPIProtocol {

  func getGeocodingInfo(
    latitude: Double, longitude: Double
  ) async throws -> Geocoding
}
