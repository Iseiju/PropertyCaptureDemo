//
//  LocationService.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import CoreLocation

final class LocationService: NSObject, LocationServiceProtocol {

  var isAuthorized: Bool {
    switch authStatus {
    case .authorizedAlways, .authorizedWhenInUse:
      return true

    default:
      return false
    }
  }

  private(set) var authStatus: CLAuthorizationStatus = .notDetermined
  private(set) var currentLocation: CLLocation?

  private let locationManager = CLLocationManager()

  override init() {
    authStatus = locationManager.authorizationStatus

    super.init()

    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }

  func requestLocationAuthorization() {
    guard authStatus == .notDetermined else { return }

    locationManager.requestWhenInUseAuthorization()
  }

  func startUpdatingLocation() {
    locationManager.startUpdatingLocation()
  }

  func stopUpdatingLocation() {
    locationManager.stopUpdatingLocation()
  }
}

// MARK: CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {

  func locationManager(
    _ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]
  ) {
    currentLocation = locations.last
  }

  func locationManager(
    _ manager: CLLocationManager, didFailWithError error: any Error
  ) {
    print(error.localizedDescription)
  }

  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    authStatus = manager.authorizationStatus
    handleAuthStatus(manager.authorizationStatus)
  }
}

// MARK: Private Functions

extension LocationService {

  private func handleAuthStatus(_ authStatus: CLAuthorizationStatus) {
    switch authStatus {
    case .authorizedAlways, .authorizedWhenInUse:
      startUpdatingLocation()

    default:
      stopUpdatingLocation()
    }
  }
}
