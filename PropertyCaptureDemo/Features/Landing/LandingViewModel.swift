//
//  LandingViewModel.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import Foundation

@Observable
final class LandingViewModel {

  let locationService: LocationServiceProtocol
  let cameraService: CameraServiceProtocol

  init(
    _ locationService: LocationServiceProtocol,
    _ cameraService: CameraServiceProtocol
  ) {
    self.locationService = locationService
    self.cameraService = cameraService
  }
}
