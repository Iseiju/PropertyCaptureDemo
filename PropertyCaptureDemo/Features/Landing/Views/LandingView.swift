//
//  LandingView.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

struct LandingView: View {

  @State private var viewModel: LandingViewModel

  @Environment(Router.self) private var router

  init(_ viewModel: LandingViewModel) {
    _viewModel = State(wrappedValue: viewModel)
  }

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
  LandingView(LandingViewModel(LocationService.shared))
}
