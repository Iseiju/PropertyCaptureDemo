//
//  PropertyFormViewModel.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import CoreLocation
import Foundation

@Observable
final class PropertyFormViewModel {

  let imageData: Data

  var propertyName: String {
    return reverseGeocodeResponse?.name.capitalized ?? ""
  }

  var propertyType: String {
    return reverseGeocodeResponse?.type.capitalized ?? ""
  }

  var isActivityViewPresented: Bool = false

  private(set) var activityItems: [ActivityItem] = []
  private var reverseGeocodeResponse: ReverseGeocodeResponse?

  private let currentLocation: CLLocation
  private let geocodingAPI: GeocodingAPIProtocol

  init(
    _ imageData: Data,
    _ currentLocation: CLLocation,
    _ geocodingAPI: GeocodingAPIProtocol
  ) {
    self.imageData = imageData
    self.currentLocation = currentLocation
    self.geocodingAPI = geocodingAPI
  }

  func getReverseGeocodeInfo() async {
    do {
      let latitude = currentLocation.coordinate.latitude
      let longitude = currentLocation.coordinate.longitude
      let reverseGeocodeResponse = try await geocodingAPI
        .getReverseGeocodeInfo(latitude, longitude)

      self.reverseGeocodeResponse = reverseGeocodeResponse
    } catch {
      print(error)
    }
  }

  func createActivityItems() {
    let imagePreviewItem = ActivityItem(
      imageData: imageData,
      title: propertyName,
      subtitle: "📍 \(propertyType)"
    )

    activityItems.append(imagePreviewItem)
  }
}
