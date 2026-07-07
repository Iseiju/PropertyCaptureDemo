//
//  PropertyCaptureViewModel.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/28/26.
//

import CoreLocation
import Foundation

final class PropertyCaptureViewModel: BasePropertyFormViewModel {

  private(set) var formUUID: UUID
  
  private let currentLocation: CLLocation
  private let geocodingAPI: GeocodingAPIProtocol

  init(
    imageData: Data,
    currentLocation: CLLocation,
    geocodingAPI: GeocodingAPIProtocol,
    propertyRepository: PropertyRepositoryProtocol
  ) {
    self.formUUID = UUID()
    self.currentLocation = currentLocation
    self.geocodingAPI = geocodingAPI

    super.init(imageData: imageData, propertyRepository: propertyRepository)
  }

  override func getReverseGeocodeInfo() async {
    do {
      requestState = .loading

      let latitude = currentLocation.coordinate.latitude
      let longitude = currentLocation.coordinate.longitude
      let reverseGeocodeResponse = try await geocodingAPI
        .getReverseGeocodeInfo(latitude, longitude)

      mapResponse(from: reverseGeocodeResponse)

      requestState = .loaded
    } catch {
      requestState = .failed(error)
    }
  }

  override func saveProperty() throws {
    if let existingProperty = try propertyRepository.getProperty(for: formUUID) {
      existingProperty.notes = notes

      return try propertyRepository.save()
    }

    let property = Property(
      id: formUUID,
      imageData: imageData,
      name: propertyName,
      type: propertyType,
      address: propertyAddress,
      notes: notes
    )

    try propertyRepository.insert(property)
  }
}

// MARK: Private Functions

extension PropertyCaptureViewModel {

  private func mapResponse(from response: ReverseGeocodeResponse) {
    propertyName = response.name.capitalized
    propertyType = response
      .type.replacingOccurrences(of: "_", with: " ").capitalized
    propertyAddress = formatAddress(from: response.address)
  }

  private func formatAddress(from address: Address) -> String {
    let components: [String] = [
      address.road ?? "",
      address.quarter ?? "",
      address.suburb ?? "",
      address.city ?? "",
      address.region ?? "",
      address.postcode ?? "",
      address.country
    ]

    var fullAddress: [String] = []

    for component in components {
      guard !component.isBlank else { continue }

      fullAddress.append(component)
    }

    return fullAddress.joined(separator: ", ")
  }
}
