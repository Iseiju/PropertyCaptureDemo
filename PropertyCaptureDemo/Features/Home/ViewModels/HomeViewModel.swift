//
//  HomeViewModel.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import CoreLocation
import Foundation

@Observable
final class HomeViewModel {

  var properties: [Property] = []

  var capturedImageData: Data? = nil
  var isImagePickerPresented: Bool = false

  var currentLocation: CLLocation? {
    return locationService.currentLocation
  }

  private let locationService: LocationService
  private let propertyRepository: PropertyRepositoryProtocol

  init(
    locationService: LocationService,
    propertyRepository: PropertyRepositoryProtocol
  ) {
    self.locationService = locationService
    self.propertyRepository = propertyRepository
  }
}

// MARK: Property Functions

extension HomeViewModel {

  func getProperties() {
    guard let properties = try? propertyRepository
      .getProperties()
    else { return }

    self.properties = properties
  }
}

// MARK: Location Functions

extension HomeViewModel {

  func requestLocationPermission() {
    locationService.requestPermission()
  }

  func stopUpdatingLocation() {
    locationService.stopUpdatingLocation()
  }
}
