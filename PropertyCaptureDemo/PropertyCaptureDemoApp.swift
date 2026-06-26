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

  @State private var locationService = LocationService()
  @State private var cameraService = CameraService()

  var body: some Scene {
    WindowGroup {
      NavigationStack(path: $router.routes) {
        LandingFactory.makeLandingView(locationService, cameraService)
          .toolbarTitleDisplayMode(.inline)
          .navigationDestination(for: RouteEnum.self) { route in
            route.destination()
          }
      }
    }
    .environment(router)
  }
}
