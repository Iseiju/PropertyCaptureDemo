//
//  PropertyCaptureDemoApp.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

@main
struct PropertyCaptureDemoApp: App {

  @State private var router = Router()

  var body: some Scene {
    WindowGroup {
      NavigationStack(path: $router.routes) {
        LandingFactory.makeLandingView()
          .navigationDestination(for: RouteEnum.self) { route in
            route.destination()
          }
      }
    }
    .environment(router)
  }
}
