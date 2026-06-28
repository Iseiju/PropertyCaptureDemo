//
//  LocationService.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import CoreLocation

@Observable
final class LocationService: NSObject {

  var currentLocation: CLLocation?
  var authStatus: CLAuthorizationStatus = .notDetermined

  @ObservationIgnored
  private let locationManager = CLLocationManager()

  override init() {
    super.init()

    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }

  func requestPermission() {
    locationManager.requestWhenInUseAuthorization()

    handleAuthStatus(authStatus)
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
      // SHOW ALERT AND NAVIGATE USER TO SETTINGS PAGE
      break
    }
  }
}
