//
//  HomeFactory.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

enum HomeFactory {

  static func makeHomeView(
    locationService: LocationServiceProtocol,
    cameraService: CameraServiceProtocol,
    propertyRepository: PropertyRepositoryProtocol
  ) -> some View {
    let viewModel = HomeViewModel(
      locationService: locationService,
      cameraService: cameraService,
      propertyRepository: propertyRepository
    )

    return HomeView(viewModel)
  }
}
