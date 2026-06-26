//
//  RouteEnum.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

enum RouteEnum: Hashable {
  case home
  case propertyForm(_ imageData: Data)
}

extension RouteEnum {

  @ViewBuilder
  func destination() -> some View {
    switch self {
    case .home:
      HomeFactory.makeHomeView()

    case .propertyForm(let imageData):
      PropertyFormFactory.makePropertyFormView(imageData)
    }
  }
}
