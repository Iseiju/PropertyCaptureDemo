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
  var isAlertPresented: Bool = false

  var hasRequiredPermissions: Bool {
    return locationService.isAuthorized && cameraService.isAuthorized
  }
  
  var currentLocation: CLLocation? { return locationService.currentLocation }

  private let locationService: LocationServiceProtocol
  private let cameraService: CameraServiceProtocol
  private let propertyRepository: PropertyRepositoryProtocol

  init(
    locationService: LocationServiceProtocol,
    cameraService: CameraServiceProtocol,
    propertyRepository: PropertyRepositoryProtocol
  ) {
    self.locationService = locationService
    self.cameraService = cameraService
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

  func startUpdatingLocation() {
    locationService.startUpdatingLocation()
  }

  func stopUpdatingLocation() {
    locationService.stopUpdatingLocation()
  }
}
