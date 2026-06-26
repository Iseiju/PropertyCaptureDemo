//
//  CaptureFormViewModel.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import Foundation

@Observable
final class CaptureFormViewModel {

  let imageData: Data

  init(_ imageData: Data) {
    self.imageData = imageData
  }
}
