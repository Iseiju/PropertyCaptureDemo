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
    Text("Capture Form")
  }
}

#Preview {
  CaptureFormView(.init(Data()))
}
