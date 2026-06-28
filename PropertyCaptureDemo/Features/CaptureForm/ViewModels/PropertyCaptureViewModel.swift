//
//  PropertyCaptureViewModel.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/28/26.
//

import CoreLocation
import Foundation

final class PropertyCaptureViewModel: BasePropertyFormViewModel {

  private var formUUID: UUID
  private var currentLocation: CLLocation

  private var geocodingAPI: GeocodingAPIProtocol
  private var propertyRepository: PropertyRepositoryProtocol

  init(
    _ imageData: Data,
    _ currentLocation: CLLocation,
    _ geocodingAPI: GeocodingAPIProtocol,
    _ propertyRepository: PropertyRepositoryProtocol
  ) {
    self.formUUID = UUID()
    self.currentLocation = currentLocation
    self.geocodingAPI = geocodingAPI
    self.propertyRepository = propertyRepository

    super.init(imageData)
  }

  override func getReverseGeocodeInfo() async throws(AppError) {
    let latitude = currentLocation.coordinate.latitude
    let longitude = currentLocation.coordinate.longitude
    let reverseGeocodeResponse = try await geocodingAPI
      .getReverseGeocodeInfo(latitude, longitude)

    mapResponse(from: reverseGeocodeResponse)
  }

  override func saveProperty() throws {
    guard (try propertyRepository
      .getProperty(for: formUUID)) == nil
    else { return }

    let property = Property(
      id: formUUID,
      imageData: imageData,
      name: propertyName,
      type: propertyType,
      address: propertyAddress,
      notes: notes
    )

    try propertyRepository.save(property)
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
