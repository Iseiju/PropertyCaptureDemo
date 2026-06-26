//
//  CaptureFormView.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

struct CaptureFormView: View {

  @State private var viewModel: CaptureFormViewModel

  @Environment(LocationService.self) private var locationService

  init(_ viewModel: CaptureFormViewModel) {
    _viewModel = State(wrappedValue: viewModel)
  }

  var body: some View {
    VStack(spacing: 12) {
      if let image = UIImage(data: viewModel.imageData) {
        Image(uiImage: image)
          .resizable()
          .scaledToFill()
          .frame(height: 400)
          .clipped()
          .clipShape(.rect(cornerRadius: 8))
      }

      Spacer()

      Button(action: {}) {
        Text("Send")
          .frame(height: 60)
          .frame(maxWidth: .infinity)
          .foregroundStyle(.white)
          .background(.blue)
          .clipShape(RoundedRectangle(cornerRadius: 60 / 2))
      }
    }
    .padding(20)
    .navigationTitle("Capture Form")
    .onAppear { locationService.requestPermission() }
    .onChange(of: locationService.currentLocation) {
      viewModel.currentLocation = locationService.currentLocation
    }
  }
}

#Preview {
  CaptureFormView(.init(Data()))
}
