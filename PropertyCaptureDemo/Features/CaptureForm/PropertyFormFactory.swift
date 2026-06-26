//
//  PropertyFormFactory.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

enum PropertyFormFactory {

  static func makePropertyFormView(_ imageData: Data) -> some View {
    return PropertyFormView(
      PropertyFormViewModel(imageData, NetworkService.shared)
    )
  }
}
