//
//  HomeView.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

struct HomeView: View {

  @State private var capturedImageData: Data? = nil

  @State private var isImagePickerPresented: Bool = false

  var body: some View {
    Text("Home")
      .navigationTitle("Home")
      .navigationBarBackButtonHidden()
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("", systemImage: "camera") {
            isImagePickerPresented.toggle()
          }
        }
      }
      .fullScreenCover(isPresented: $isImagePickerPresented) {
        ImagePickerView(imageData: $capturedImageData)
      }
  }
}

#Preview {
  HomeView()
}
