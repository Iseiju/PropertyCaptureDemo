//
//  PropertyFormView.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

struct PropertyFormView: View {

  @State private var viewModel: PropertyFormViewModel

  init(_ viewModel: PropertyFormViewModel) {
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
    .navigationTitle("Property Details")
    .task { await viewModel.getReverseGeocodeInfo() }
  }
}

//#Preview {
//  PropertyFormView(.init(Data()))
//}
