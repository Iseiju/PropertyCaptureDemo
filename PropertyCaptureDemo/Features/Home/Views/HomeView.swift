//
//  HomeView.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

struct HomeView: View {

  @State private var viewModel: HomeViewModel

  @Environment(Router.self) private var router
  @Environment(LocationService.self) private var locationService

  init(_ viewModel: HomeViewModel) {
    _viewModel = State(wrappedValue: viewModel)
  }

  var body: some View {
    List(viewModel.properties) { property in
      PropertyItemView(property: property)
        .listRowSeparator(.hidden)
    }
    .listStyle(.plain)
    .navigationTitle("Home")
    .navigationBarBackButtonHidden()
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button("", systemImage: "camera") {
          viewModel.isImagePickerPresented.toggle()
        }
      }
    }
    .fullScreenCover(isPresented: $viewModel.isImagePickerPresented) {
      ImagePickerView(imageData: $viewModel.capturedImageData)
    }
    .task { try? await viewModel.getProperties() }
    .onChange(of: viewModel.capturedImageData) {
      locationService.requestPermission()
    }
    .onChange(of: locationService.currentLocation) {
      guard let imageData = viewModel.capturedImageData,
            let currentLocation = locationService.currentLocation
      else { return }

      locationService.stopUpdatingLocation()

      router.push(to: .propertyForm(imageData, currentLocation))
    }
  }
}

#Preview {
  let container = AppContainer()

  HomeView(HomeViewModel(container.propertyRepository))
}
