//
//  PropertyFormViewModel.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import CoreLocation
import Foundation
import UniformTypeIdentifiers

@Observable
final class PropertyFormViewModel {

  let formUUID: UUID
  let imageData: Data

  var notes: String = ""
  var isActivityViewPresented: Bool = false

  var propertyName: String {
    return reverseGeocodeResponse?.name.capitalized ?? ""
  }

  var propertyType: String {
    return reverseGeocodeResponse?.type.capitalized ?? ""
  }

  var propertyAddress: String {
    guard let address = reverseGeocodeResponse?.address else { return "" }

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

  var isSendButtonEnabled: Bool {
    return reverseGeocodeResponse != nil && !notes.isBlank
  }

  private(set) var activityItems: [Any] = []
  private(set) var reverseGeocodeResponse: ReverseGeocodeResponse?

  private let currentLocation: CLLocation
  private let geocodingAPI: GeocodingAPIProtocol
  private let propertyRepository: PropertyRepositoryProtocol

  init(
    _ imageData: Data,
    _ currentLocation: CLLocation,
    _ geocodingAPI: GeocodingAPIProtocol,
    _ propertyRepository: PropertyRepositoryProtocol
  ) {
    self.formUUID = UUID()
    self.imageData = imageData
    self.currentLocation = currentLocation
    self.geocodingAPI = geocodingAPI
    self.propertyRepository = propertyRepository
  }
}

// MARK: Reverse Geocode Functions

extension PropertyFormViewModel {

  func getReverseGeocodeInfo() async throws(AppError) {
    do {
      let latitude = currentLocation.coordinate.latitude
      let longitude = currentLocation.coordinate.longitude
      let reverseGeocodeResponse = try await geocodingAPI
        .getReverseGeocodeInfo(latitude, longitude)

      self.reverseGeocodeResponse = reverseGeocodeResponse
    } catch {
      throw error
    }
  }
}

// MARK: User Initiated

extension PropertyFormViewModel {

  func createActivityItems() {
    guard reverseGeocodeResponse != nil else { return }

    activityItems.removeAll()

    let imagePreviewItem = ActivityItem(
      imageData: imageData,
      title: propertyName,
      subtitle: "📍 \(propertyType)"
    )

    let details = [
      "Name: \(propertyName)",
      "Type: \(propertyType)",
      "Address: \(propertyAddress)",
      "Notes: \(notes)"
    ]
      .joined(separator: "\n")

    activityItems.append(imagePreviewItem)
    activityItems.append(details)
  }
}

// MARK: Persistence

extension PropertyFormViewModel {

  func saveProperty() throws {
    do {
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
    } catch {
      throw error
    }
  }
}
