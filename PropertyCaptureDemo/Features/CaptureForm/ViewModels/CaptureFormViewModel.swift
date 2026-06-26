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

  init(_ imageData: Data) {
    self.imageData = imageData
  }
}
