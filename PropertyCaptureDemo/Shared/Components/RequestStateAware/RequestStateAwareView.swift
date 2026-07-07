//
//  RequestStateAwareView.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 7/7/26.
//

import SwiftUI

struct RequestStateAwareView<Placeholder: View, Content: View>: View {

  @Binding var requestState: RequestState

  var placeholder: () -> Placeholder
  var content: () -> Content
  var didTapRetry: () -> Void

  var body: some View {
    switch requestState {
    case .idle:
      Color.clear

    case .loading:
      placeholder()

    case .loaded:
      content()

    case .failed(let appError):
      VStack(alignment: .center, spacing: 16) {
        VStack(spacing: 8) {
          Text("Something went wrong")
          Text(appError.localizedDescription)
        }

        Button { didTapRetry() } label: {
          Text("Retry")
            .font(.system(size: 16, weight: .semibold))
            .padding(.vertical)
            .padding(.horizontal, 40)
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 60 / 2))
        }
      }
    }
  }
}

#Preview {
  RequestStateAwareView(
    requestState: .constant(.failed(.badURL)),
    placeholder: { Text("Placeholder") },
    content: { Text("Content") },
    didTapRetry: {}
  )
}
