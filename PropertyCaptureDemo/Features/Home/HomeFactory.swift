//
//  HomeFactory.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

enum HomeFactory {

  static func makeHomeView(
    _ propertyRepository: PropertyRepository
  ) -> some View {
    return HomeView(HomeViewModel(propertyRepository))
  }
}
