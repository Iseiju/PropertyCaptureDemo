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
    ScrollView(.vertical) {
      VStack(spacing: 12) {
        if let image = UIImage(data: viewModel.imageData) {
          Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(height: 400)
            .clipped()
            .clipShape(.rect(cornerRadius: 8))
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

          viewModel.createActivityItems()
          viewModel.isActivityViewPresented.toggle()
        } label: {
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
    }
    .navigationTitle("Property Details")
    .sheet(isPresented: $viewModel.isActivityViewPresented) {
      ActivityView(items: viewModel.activityItems)
    }
    .task { try? await viewModel.getReverseGeocodeInfo() }
  }
}

//#Preview {
//  PropertyFormView(.init(Data()))
//}
