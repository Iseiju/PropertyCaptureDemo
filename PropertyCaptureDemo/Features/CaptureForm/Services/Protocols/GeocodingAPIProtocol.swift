//
//  GeocodingAPIProtocol.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/27/26.
//

import Foundation

protocol GeocodingAPIProtocol {

  func getReverseGeocodeInfo(
    _ latitude: Double, _ longitude: Double
  ) async throws(AppError) -> ReverseGeocodeResponse
}
