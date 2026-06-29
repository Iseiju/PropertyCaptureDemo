//
//  LocationServiceProtocol.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/29/26.
//

import CoreLocation

protocol LocationServiceProtocol {

  var isAuthorized: Bool { get }
  var currentLocation: CLLocation? { get }

  func requestLocationAuthorization()
  func startUpdatingLocation()
  func stopUpdatingLocation()
}
