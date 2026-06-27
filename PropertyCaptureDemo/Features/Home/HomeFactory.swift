//
//  HomeFactory.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

enum HomeFactory {

  static func makeHomeView(
    _ propertyRepository: PropertyRepositoryProtocol
  ) -> some View {
    let viewModel = HomeViewModel(propertyRepository)
    
    return HomeView(viewModel)
  }
}
