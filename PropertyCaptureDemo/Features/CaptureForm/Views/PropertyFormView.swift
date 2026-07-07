//
//  PropertyFormView.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import CoreLocation
import SwiftUI

struct PropertyFormView: View {

  @State private var viewModel: BasePropertyFormViewModel

  init(_ viewModel: BasePropertyFormViewModel) {
    _viewModel = State(wrappedValue: viewModel)
  }

  var body: some View {
    RequestStateAwareView(
      requestState: $viewModel.requestState,
      placeholder: { placeholder() },
      content: { contentView() },
      didTapRetry: {
        Task { await viewModel.getReverseGeocodeInfo() }
      }
    )
    .navigationTitle("Property Details")
    .sheet(isPresented: $viewModel.isActivityViewPresented) {
      ActivityView(items: viewModel.activityItems)
    }
    .task { await viewModel.getReverseGeocodeInfo() }
  }
}

// MARK: View Functions

extension PropertyFormView {

  private func contentView() -> some View {
    ScrollView(.vertical) {
      VStack(spacing: 12) {
        if let image = UIImage(data: viewModel.imageData) {
          Image(uiImage: image)
            .resizable()
            .frame(height: 400)
            .scaledToFill()
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .overlay {
              RoundedRectangle(cornerRadius: 8, style: .continuous)
                .strokeBorder(.black, lineWidth: 1)
            }
        }

        VStack(alignment: .leading, spacing: 8) {
          LabeledText(title: "Name", text: viewModel.propertyName)
          LabeledText(title: "Type", text: viewModel.propertyType)
          LabeledText(title: "Address", text: viewModel.propertyAddress)

          Text("Notes")
            .font(.system(size: 16, weight: .semibold))
            .padding(.top, 12)

          TextEditor(text: $viewModel.notes)
            .font(.system(size: 14, weight: .regular))
            .frame(height: 60)
            .padding(12)
            .overlay {
              RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: 1.0)
            }
        }

        Spacer()

        Button {
          UIApplication.shared.endEditing()
          viewModel.isActivityViewPresented = true

          try? viewModel.saveProperty()
        } label: {
          Text("Send")
            .font(.system(size: 16, weight: .semibold))
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(viewModel.isSendButtonEnabled ? .blue : .gray)
            .clipShape(RoundedRectangle(cornerRadius: 60 / 2))
        }
        .disabled(!viewModel.isSendButtonEnabled)
      }
      .padding(20)
    }
  }

  private func placeholder() -> some View {
    contentView()
      .redacted(reason: .placeholder)
      .disabled(true)
  }
}

#Preview {
  let container = AppContainer()
  let vm = PropertyDetailsViewModel(
    property: .dummyProperty(),
    propertyRepository: container.propertyRepository
  )

  PropertyFormView(vm)
}
