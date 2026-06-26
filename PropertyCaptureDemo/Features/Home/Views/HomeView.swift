//
//  HomeView.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

struct HomeView: View {

  @State private var viewModel = HomeViewModel()

  @Environment(Router.self) private var router

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

        router.push(to: .captureForm(imageData))
      }
  }
}

#Preview {
  HomeView()
}
