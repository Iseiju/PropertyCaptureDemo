//
//  LocationService.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import CoreLocation

protocol LocationServiceProtocol {

  var currentLocation: CLLocation? { get }

  func requestPermission()
  func startUpdatingLocation()
  func stopUpdatingLocation()
}

@Observable
final class LocationService: NSObject, LocationServiceProtocol {

  var currentLocation: CLLocation?
  var authStatus: CLAuthorizationStatus = .notDetermined

  @ObservationIgnored
  private let locationManager = CLLocationManager()

  override init() {
    super.init()

    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest

    authStatus = locationManager.authorizationStatus
  }

  func requestPermission() {
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

    switch authStatus{
    case .authorizedAlways, .authorizedWhenInUse:
      startUpdatingLocation()

    default:
      // SHOW ALERT AND NAVIGATE USER TO SETTINGS PAGE
      break
    }
  }
}
