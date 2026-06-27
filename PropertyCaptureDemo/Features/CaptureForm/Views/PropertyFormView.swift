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
    VStack( spacing: 12) {
      if let image = UIImage(data: viewModel.imageData) {
        Image(uiImage: image)
          .resizable()
          .scaledToFill()
          .frame(height: 400)
          .clipped()
          .clipShape(.rect(cornerRadius: 8))
      }

      VStack(alignment: .leading, spacing: 8) {
        Text("Property Name")
          .font(.system(size: 16, weight: .semibold))

        Text(viewModel.propertyName)
          .font(.system(size: 14, weight: .regular))
          .padding(.leading, 8)

        divider()

        Text("Property Type")
          .font(.system(size: 16, weight: .semibold))

        Text(viewModel.propertyType)
          .font(.system(size: 14, weight: .regular))
          .padding(.leading, 8)

        divider()
      }

      Spacer()

      Button { viewModel.isActivityViewPresented.toggle() } label: {
        Text("Send")
          .font(.system(size: 16, weight: .semibold))
          .frame(height: 60)
          .frame(maxWidth: .infinity)
          .foregroundStyle(.white)
          .background(.blue)
          .clipShape(RoundedRectangle(cornerRadius: 60 / 2))
      }
    }
    .padding(20)
    .navigationTitle("Property Details")
    .sheet(isPresented: $viewModel.isActivityViewPresented) {
      ActivityView(items: [])
    }
    .task { await viewModel.getReverseGeocodeInfo() }
  }
}

// MARK: Private Functions

extension PropertyFormView {

  private func divider() -> some View {
    Divider()
      .frame(height: 1)
      .overlay(.placeholder)
  }
}

//#Preview {
//  PropertyFormView(.init(Data()))
//}
