//
//  PropertyCaptureViewModelTest.swift
//  PropertyFormViewModelText
//
//  Created by Kenneth James Uy on 6/26/26.
//

import XCTest
import CoreLocation
@testable import PropertyCaptureDemo

@MainActor
final class PropertyCaptureViewModelTest: XCTestCase {

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

      XCTAssertEqual(sut.propertyName, "Crusoe Cabins At Costa Azalea")
      XCTAssertEqual(sut.propertyType, "Beach Resort")
      XCTAssertEqual(sut.propertyAddress, "Circumferential Road, Limao, Samal, Davao Region, 8119, Philippines")
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
      XCTAssertTrue(sut.propertyName.isBlank)
      XCTAssertTrue(sut.propertyType.isBlank)
      XCTAssertTrue(sut.propertyAddress.isBlank)
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

    XCTAssertFalse(sut.imageData.isEmpty)
    XCTAssertTrue(sut.propertyName.isEmpty)
    XCTAssertTrue(sut.propertyType.isEmpty)
    XCTAssertTrue(sut.propertyAddress.isEmpty)
    XCTAssertTrue(sut.notes.isEmpty)
    XCTAssertFalse(sut.activityItems.isEmpty)
  }
}

// MARK: Make SUT

extension PropertyCaptureViewModelTest {

  private func makeSpyPropertyFormVM() -> (PropertyCaptureViewModel, GeocodingAPISpy) {
    let imageData = Data(repeating: 0xFF, count: 1024)
    let location = CLLocation(
      latitude: 7.087357181983118, longitude: 125.66729262828807
    )
    let geocodingAPISpy = GeocodingAPISpy()
    let propertyRepositoryMock = PropertyRepositoryMock()
    let sut = PropertyCaptureViewModel(
      imageData, location, geocodingAPISpy, propertyRepositoryMock
    )

    return (sut, geocodingAPISpy)
  }

  private func makeMockPropertyFormVM() -> (PropertyCaptureViewModel, GeocodingAPIMock) {
    let imageData = Data(repeating: 0xFF, count: 1024)
    let location = CLLocation(
      latitude: 7.087357181983118, longitude: 125.66729262828807
    )
    let geocodingAPIMock = GeocodingAPIMock()
    let propertyRepositoryMock = PropertyRepositoryMock()
    let sut = PropertyCaptureViewModel(
      imageData, location, geocodingAPIMock, propertyRepositoryMock
    )

    return (sut, geocodingAPIMock)
  }
}
