//
//  HomeFactory.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

enum HomeFactory {

  static func makeHomeView(
    locationService: LocationService,
    propertyRepository: PropertyRepositoryProtocol
  ) -> some View {
    let viewModel = HomeViewModel(
      locationService: locationService, propertyRepository: propertyRepository
    )

    return HomeView(viewModel)
  }
}
