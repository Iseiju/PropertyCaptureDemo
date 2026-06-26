//
//  LandingViewModel.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import Foundation

@Observable
final class LandingViewModel {

  private let locationService: LocationServiceProtocol

  init(_ locationService: LocationServiceProtocol) {
    self.locationService = locationService
  }
}
