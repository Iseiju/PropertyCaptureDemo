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
    Text(property.name)
  }
}

#Preview {
  PropertyItemView(property: .dummyProperty())
}
