//
//  CaptureFormView.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

struct CaptureFormView: View {

  @State private var viewModel: CaptureFormViewModel

  init(_ viewModel: CaptureFormViewModel) {
    _viewModel = State(wrappedValue: viewModel)
  }

  var body: some View {
    VStack(spacing: 8) {
      if let image = UIImage(data: viewModel.imageData) {
        Image(uiImage: image)
          .resizable()
          .scaledToFill()
          .frame(height: 400)
          .clipped()
          .clipShape(.rect(cornerRadius: 8))
      }

      Spacer()
    }
    .padding(20)
    .navigationTitle("Capture Form")
  }
}

#Preview {
  CaptureFormView(.init(Data()))
}
