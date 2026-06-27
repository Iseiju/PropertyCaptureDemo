//
//  LabeledText.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/27/26.
//

import SwiftUI

struct LabeledText: View {

  var title: String
  var text: String

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(title)
        .font(.system(size: 16, weight: .semibold))

      Text(text)
        .multilineTextAlignment(.leading)
        .lineLimit(2)
        .font(.system(size: 14, weight: .regular))
        .padding(.leading, 8)

      Divider()
        .frame(height: 1)
        .overlay(.placeholder)
    }
  }
}

#Preview {
  LabeledText(title: "Type", text: "Text")
}
