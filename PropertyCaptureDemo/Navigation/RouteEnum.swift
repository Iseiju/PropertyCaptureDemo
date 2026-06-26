//
//  RouteEnum.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

enum RouteEnum: Hashable {
  case home
  case captureForm
}

extension RouteEnum {

  @ViewBuilder
  func destination() -> some View {
    switch self {
    case .home:
      HomeFactory.makeHomeView()

    case .captureForm:
      CaptureFormFactory.makeCaptureFormView()
    }
  }
}
