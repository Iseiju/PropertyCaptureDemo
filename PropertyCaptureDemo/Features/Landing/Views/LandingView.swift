//
//  LandingView.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

struct LandingView: View {
  
  @Environment(Router.self) private var router

  var body: some View {
    Text("Landing")
      .task { await pushToHome() }
  }
}

// MARK: Navigation

extension LandingView {

  private func pushToHome() async {
    try? await Task.sleep(for: .seconds(1))

    router.push(to: .home)
  }
}

#Preview {
  LandingView()
}
