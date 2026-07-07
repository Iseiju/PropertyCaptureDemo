//
//  PropertyDetailsViewModel.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/28/26.
//

import Foundation

final class PropertyDetailsViewModel: BasePropertyFormViewModel {

  private let property: Property

  init(property: Property, propertyRepository: PropertyRepositoryProtocol) {
    self.property = property

    super.init(
      imageData: property.imageData, propertyRepository: propertyRepository
    )

    propertyName = property.name
    propertyType = property.type
    propertyAddress = property.address
    notes = property.notes

    requestState = .loaded
  }

  override func saveProperty() throws {
    property.notes = notes

    try propertyRepository.save()
  }
}
