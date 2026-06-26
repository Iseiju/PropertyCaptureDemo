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

final class LocationService: NSObject, LocationServiceProtocol {

  static var shared = LocationService()

  var currentLocation: CLLocation?

  private let locationManager = CLLocationManager()

  override init() {
    super.init()

    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
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
    print("Failed to get live location: \(error.localizedDescription)")
  }

//  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//    switch manager.authorizationStatus {
//      case .authorizedAlways, .authorizedWhenInUse:
//      requestLocation()
//
//    case .denied, .restricted:
//      print("Location access denied")
//
//    case .notDetermined:
//      break
//
//    default:
//      break
//    }
//  }
}
