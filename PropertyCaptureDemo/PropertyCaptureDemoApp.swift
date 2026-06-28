//
//  PropertyCaptureDemoApp.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftData
import SwiftUI

@main
struct PropertyCaptureDemoApp: App {

  @State private var router = Router()

  private let appContainer = AppContainer()

  var body: some Scene {
    WindowGroup {
      NavigationStack(path: $router.routes) {
        LandingFactory.makeLandingView()
          .toolbarTitleDisplayMode(.inline)
          .navigationDestination(for: Route.self) { route in
            route.destination(appContainer)
          }
      }
    }
    .environment(router)
    .modelContainer(appContainer.modelContainer)
  }
}
