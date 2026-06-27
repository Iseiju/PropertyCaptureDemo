//
//  PropertyFormViewModelTest.swift
//  PropertyFormViewModelText
//
//  Created by Kenneth James Uy on 6/26/26.
//

import XCTest
import CoreLocation
@testable import PropertyCaptureDemo

final class PropertyFormViewModelTest: XCTestCase {

}

// MARK: Make SUT

extension PropertyFormViewModelTest {

  @MainActor
  private func makeSpyPropertyFormVM() -> (PropertyFormViewModel, GeocodingAPISpy) {
    let geocodingAPISpy = GeocodingAPISpy()
    let sut = PropertyFormViewModel(Data(), CLLocation(), geocodingAPISpy)

    return (sut, geocodingAPISpy)
  }

  @MainActor
  private func makeMockPropertyFormVM() -> (PropertyFormViewModel, GeocodingAPIMock) {
    let geocodingAPIMock = GeocodingAPIMock()
    let sut = PropertyFormViewModel(Data(), CLLocation(), geocodingAPIMock)

    return (sut, geocodingAPIMock)
  }
}

