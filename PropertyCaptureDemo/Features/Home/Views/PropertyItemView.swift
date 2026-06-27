//
//  PropertyItemView.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/27/26.
//

import SwiftUI

struct PropertyItemView: View {

  var property: Property

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      if let image = UIImage(data: property.imageData) {
        Image(uiImage: image)
          .resizable()
          .scaledToFill()
          .frame(height: 260)
          .clipped()
      }

      VStack(alignment: .leading, spacing: 4) {
        Text(property.name)
          .font(.system(size: 16, weight: .semibold))

        Text(property.address)
          .font(.system(size: 14, weight: .regular))
          .multilineTextAlignment(.leading)
          .lineLimit(2)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(12)
    }
    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    .overlay {
      RoundedRectangle(cornerRadius: 8, style: .continuous)
        .strokeBorder(.black, lineWidth: 1)
    }
  }
}

#Preview {
  PropertyItemView(property: .dummyProperty())
}
