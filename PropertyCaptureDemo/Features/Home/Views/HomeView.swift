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

  init(_ viewModel: HomeViewModel) {
    _viewModel = State(wrappedValue: viewModel)
  }

  var body: some View {
    List(viewModel.properties) { property in
      PropertyItemView(property: property)
        .listRowSeparator(.hidden)
        .onTapGesture {
          viewModel.stopUpdatingLocation()
          router.push(to: .propertyDetails(property))
        }
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
    .onAppear { viewModel.requestLocationPermission() }
    .onDisappear { viewModel.stopUpdatingLocation() }
    .onChange(of: viewModel.capturedImageData) {
      pushToPropertyForm()
    }
  }
}

// MARK: Navigation

extension HomeView {

  private func pushToPropertyForm() {
    guard let data = viewModel.capturedImageData,
          let location = viewModel.currentLocation
    else { return }

    router.push(to: .propertyForm(imageData: data, currentLocation: location))
  }
}

#Preview {
  let container = AppContainer()
  let vm = HomeViewModel(
    locationService: container.locationService,
    propertyRepository: container.propertyRepository
  )

  HomeView(vm)
}
