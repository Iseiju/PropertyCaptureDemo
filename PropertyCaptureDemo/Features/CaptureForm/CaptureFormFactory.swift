//
//  CaptureFormFactory.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

enum CaptureFormFactory {

  static func makeCaptureFormView(_ imageData: Data) -> some View {
    return CaptureFormView(
      CaptureFormViewModel(imageData, NetworkService.shared)
    )
  }
}
