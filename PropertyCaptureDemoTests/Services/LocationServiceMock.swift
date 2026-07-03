//
//  LocationServiceMock.swift
//  PropertyCaptureDemoTests
//
//  Created by Kenneth James Uy on 7/3/26.
//

import CoreLocation
@testable import PropertyCaptureDemo

final class LocationServiceMock: LocationServiceProtocol {

  private(set) var isAuthorized: Bool = false
  private(set) var currentLocation: CLLocation? = nil

  private(set) var didRequestAuthorization = false
  private(set) var didStartUpdating = false
  private(set) var didStopUpdating = false

  private let locations: [CLLocation]

  init(locations: [CLLocation]) {
    self.locations = locations
  }

  func requestLocationAuthorization() {
    didRequestAuthorization = true
    isAuthorized = true
  }
  
  func startUpdatingLocation() {
    didStartUpdating = true
    currentLocation = locations.last
  }
  
  func stopUpdatingLocation() {
    didStopUpdating = true
  }
}
