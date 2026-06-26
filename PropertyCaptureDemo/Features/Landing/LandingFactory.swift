//
//  LandingFactory.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

enum LandingFactory {

  static func makeLandingView(
    _ locationService: LocationServiceProtocol,
    _ cameraService: CameraServiceProtocol
  ) -> some View {
    return LandingView(LandingViewModel(locationService, cameraService))
  }
}
