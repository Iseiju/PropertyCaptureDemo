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
    Text("Home")
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
      .onChange(of: viewModel.capturedImageData) {
        guard let imageData = viewModel.capturedImageData else { return }

        router.push(to: .propertyForm(imageData))
      }
  }
}

#Preview {
  HomeView(.init())
}
