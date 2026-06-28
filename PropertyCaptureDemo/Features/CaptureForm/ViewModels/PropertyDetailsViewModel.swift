//
//  PropertyDetailsViewModel.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/28/26.
//

import Foundation

final class PropertyDetailsViewModel: BasePropertyFormViewModel {

  init(_ property: Property) {
    super.init(property.imageData)

    propertyName = property.name
    propertyType = property.type
    propertyAddress = property.address
    notes = property.notes
  }
}
