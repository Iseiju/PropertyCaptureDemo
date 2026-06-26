//
//  Router.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import Foundation

@Observable
final class Router {

  var routes: [RouteEnum] = []

  func push(to route: RouteEnum) {
    routes.append(route)
  }

  func pop() {
    guard !routes.isEmpty else { return }

    routes.removeLast()
  }
}
