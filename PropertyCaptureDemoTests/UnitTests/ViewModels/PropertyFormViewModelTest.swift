//
//  PropertyFormViewModelTest.swift
//  PropertyFormViewModelText
//
//  Created by Kenneth James Uy on 6/26/26.
//

import XCTest
import CoreLocation
@testable import PropertyCaptureDemo

@MainActor
final class PropertyFormViewModelTest: XCTestCase {

  func testGetReverseGeocodeInfoCalled() async {
    let (sut, spy) = makeSpyPropertyFormVM()

    try? await sut.getReverseGeocodeInfo()

    XCTAssertEqual(spy.called, [.getReverseGeocodeInfo(7.087357181983118, 125.66729262828807)])
  }

  func testGetReverseGeocodeInfoSuccess() async {
    let (sut, mock) = makeMockPropertyFormVM()
    let stubAddress = Address(
      road: "Circumferential Road",
      quarter: nil,
      suburb: "Limao",
      city: "Samal",
      region: "Davao Region",
      postcode: "8119",
      country: "Philippines"
    )
    let stubReverseGeocode = ReverseGeocodeResponse(
      placeId: 261460442,
      name: "Crusoe Cabins at Costa Azalea",
      type: "beach_resort",
      address: stubAddress
    )

    mock.getReverseGeocodeInfoResult = .success(stubReverseGeocode)

    do {
      try await sut.getReverseGeocodeInfo()

      XCTAssertNotNil(sut.reverseGeocodeResponse)
      XCTAssertEqual(sut.reverseGeocodeResponse?.name, "Crusoe Cabins at Costa Azalea")
      XCTAssertEqual(sut.reverseGeocodeResponse?.address.road, "Circumferential Road")
    } catch {
      XCTFail("Get Reverse Geocode request should succeed")
    }
  }

  func testGetReverseGeocodeInfoFailed() async {
    let (sut, mock) = makeMockPropertyFormVM()
    mock.getReverseGeocodeInfoResult = .failure(.badServerResponse(message: "Unknown Error"))

    do {
      try await sut.getReverseGeocodeInfo()

      XCTFail("Get Reverse Geocode request should fail")
    } catch {
      XCTAssertNil(sut.reverseGeocodeResponse)
      XCTAssertEqual(error.localizedDescription, "Unknown Error")
    }
  }

  func testCreateActivityItemsHasGeocodeInfo() async {
    let (sut, mock) = makeMockPropertyFormVM()
    let stubAddress = Address(
      road: "Circumferential Road",
      quarter: nil,
      suburb: "Limao",
      city: "Samal",
      region: "Davao Region",
      postcode: "8119",
      country: "Philippines"
    )
    let stubReverseGeocode = ReverseGeocodeResponse(
      placeId: 261460442,
      name: "Crusoe Cabins at Costa Azalea",
      type: "beach_resort",
      address: stubAddress
    )

    mock.getReverseGeocodeInfoResult = .success(stubReverseGeocode)
    try? await sut.getReverseGeocodeInfo()

    sut.notes = "Sample Notes"
    sut.createActivityItems()

    XCTAssertFalse(sut.imageData.isEmpty)
    XCTAssertFalse(sut.propertyName.isEmpty)
    XCTAssertFalse(sut.propertyType.isEmpty)
    XCTAssertFalse(sut.propertyAddress.isEmpty)
    XCTAssertFalse(sut.notes.isEmpty)
    XCTAssertFalse(sut.activityItems.isEmpty)
  }
  
  func testCreateActivityItemsNoGeocodeInfo() async {
    let (sut, mock) = makeMockPropertyFormVM()
    mock.getReverseGeocodeInfoResult = .failure(.badServerResponse(message: nil))
    try? await sut.getReverseGeocodeInfo()

    sut.createActivityItems()

    XCTAssertFalse(sut.imageData.isEmpty)
    XCTAssertTrue(sut.propertyName.isEmpty)
    XCTAssertTrue(sut.propertyType.isEmpty)
    XCTAssertTrue(sut.propertyAddress.isEmpty)
    XCTAssertTrue(sut.notes.isEmpty)
    XCTAssertTrue(sut.activityItems.isEmpty)
  }
}

// MARK: Make SUT

extension PropertyFormViewModelTest {

  private func makeSpyPropertyFormVM() -> (PropertyFormViewModel, GeocodingAPISpy) {
    let imageData = Data(repeating: 0xFF, count: 1024)
    let location = CLLocation(
      latitude: 7.087357181983118, longitude: 125.66729262828807
    )
    let geocodingAPISpy = GeocodingAPISpy()
    let propertyRepositoryMock = PropertyRepositoryMock()
    let sut = PropertyFormViewModel(
      imageData, location, geocodingAPISpy, propertyRepositoryMock
    )

    return (sut, geocodingAPISpy)
  }

  private func makeMockPropertyFormVM() -> (PropertyFormViewModel, GeocodingAPIMock) {
    let imageData = Data(repeating: 0xFF, count: 1024)
    let location = CLLocation(
      latitude: 7.087357181983118, longitude: 125.66729262828807
    )
    let geocodingAPIMock = GeocodingAPIMock()
    let propertyRepositoryMock = PropertyRepositoryMock()
    let sut = PropertyFormViewModel(
      imageData, location, geocodingAPIMock, propertyRepositoryMock
    )

    return (sut, geocodingAPIMock)
  }
}
