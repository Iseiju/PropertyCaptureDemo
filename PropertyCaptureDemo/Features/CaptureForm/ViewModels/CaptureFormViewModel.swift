//
//  CaptureFormViewModel.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import CoreLocation
import Foundation

@Observable
final class CaptureFormViewModel {

  var currentLocation: CLLocation?

  let imageData: Data

  private let networkService: NetworkServiceProtocol

  init(_ imageData: Data, _ networkService: NetworkServiceProtocol) {
    self.imageData = imageData
    self.networkService = networkService
  }
}
