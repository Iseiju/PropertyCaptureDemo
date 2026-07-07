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
    let location = CLLocation(
      latitude: 7.097357181983118, longitude: 126.66729262828807
    )
    let (sut, spyAPI, _) = makeSpyPropertyCaptureVM(location: location)

    await sut.getReverseGeocodeInfo()

    XCTAssertEqual(spyAPI.called, [.getReverseGeocodeInfo(7.097357181983118, 126.66729262828807)])
  }

  func testGetReverseGeocodeInfoSuccess() async {
    let (sut, mockAPI, _) = makeMockPropertyCaptureVM()
    let stubReverseGeocode = makeStubReverseGeocodeResponse()
    mockAPI.getReverseGeocodeInfoResult = .success(stubReverseGeocode)

    await sut.getReverseGeocodeInfo()

    guard case .loaded = sut.requestState else {
      XCTFail("Get Reverse Geocode request should succeed")
      return
    }

    XCTAssertEqual(sut.propertyName, "Crusoe Cabins At Costa Azalea")
    XCTAssertEqual(sut.propertyType, "Beach Resort")
    XCTAssertEqual(sut.propertyAddress, "Circumferential Road, Limao, Samal, Davao Region, 8119, Philippines")
  }

  func testGetReverseGeocodeInfoFailed() async {
    let (sut, mockAPI, _) = makeMockPropertyCaptureVM()
    mockAPI.getReverseGeocodeInfoResult = .failure(.badServerResponse(message: "Unknown Error"))

    await sut.getReverseGeocodeInfo()

    guard case .failed(let error) = sut.requestState else {
      XCTFail("Get Reverse Geocode request should fail")
      return
    }

    XCTAssertTrue(sut.propertyName.isBlank)
    XCTAssertTrue(sut.propertyType.isBlank)
    XCTAssertTrue(sut.propertyAddress.isBlank)
    XCTAssertEqual(error.localizedDescription, "Unknown Error")
  }

  func testCreateActivityItemsHasGeocodeInfo() async {
    let (sut, mockAPI, _) = makeMockPropertyCaptureVM()
    let stubReverseGeocode = makeStubReverseGeocodeResponse()
    mockAPI.getReverseGeocodeInfoResult = .success(stubReverseGeocode)

    await sut.getReverseGeocodeInfo()

    sut.notes = "Sample Notes"

    XCTAssertFalse(sut.imageData.isEmpty)
    XCTAssertFalse(sut.propertyName.isEmpty)
    XCTAssertFalse(sut.propertyType.isEmpty)
    XCTAssertFalse(sut.propertyAddress.isEmpty)
    XCTAssertFalse(sut.notes.isEmpty)
    XCTAssertFalse(sut.activityItems.isEmpty)
  }
  
  func testCreateActivityItemsNoGeocodeInfo() async {
    let (sut, mockAPI, _) = makeMockPropertyCaptureVM()
    mockAPI.getReverseGeocodeInfoResult = .failure(.badServerResponse(message: nil))

    await sut.getReverseGeocodeInfo()

    XCTAssertFalse(sut.imageData.isEmpty)
    XCTAssertTrue(sut.propertyName.isEmpty)
    XCTAssertTrue(sut.propertyType.isEmpty)
    XCTAssertTrue(sut.propertyAddress.isEmpty)
    XCTAssertTrue(sut.notes.isEmpty)
    XCTAssertFalse(sut.activityItems.isEmpty)
  }

  func testSaveNewProperty() async {
    let imageData = Data(repeating: 0xFF, count: 1022)
    let (sut, _, mockRepository) = makeMockPropertyCaptureVM(imageData: imageData)
    let uuid = sut.formUUID
    sut.propertyName = "Crusoe Cabins At Costa Azalea"
    sut.propertyType = "Beach Resort"
    sut.propertyAddress = "Circumferential Road, Limao, Samal, Davao Region, 8119, Philippines"
    sut.notes = "Sample Notes"

    try? sut.saveProperty()

    let savedProperty = try? mockRepository.getProperty(for: uuid)

    XCTAssertNotNil(savedProperty)
    XCTAssertEqual(savedProperty?.imageData, Data(repeating: 0xFF, count: 1022))
    XCTAssertEqual(savedProperty?.name, "Crusoe Cabins At Costa Azalea")
    XCTAssertEqual(savedProperty?.type, "Beach Resort")
    XCTAssertEqual(savedProperty?.address, "Circumferential Road, Limao, Samal, Davao Region, 8119, Philippines")
    XCTAssertEqual(savedProperty?.notes, "Sample Notes")
  }
}

// MARK: Make SUT

extension PropertyCaptureViewModelTest {

  private func makeSpyPropertyCaptureVM(
    imageData: Data = .init(repeating: 0xFF, count: 1024),
    location: CLLocation = .init(latitude: 7.087357181983118, longitude: 125.66729262828807)
  ) -> (PropertyCaptureViewModel, GeocodingAPISpy, PropertyRepositoryMock) {
    let geocodingAPISpy = GeocodingAPISpy()
    let propertyRepositoryMock = PropertyRepositoryMock(properties: [])
    let sut = PropertyCaptureViewModel(
      imageData: imageData,
      currentLocation: location,
      geocodingAPI: geocodingAPISpy,
      propertyRepository: propertyRepositoryMock
    )

    return (sut, geocodingAPISpy, propertyRepositoryMock)
  }

  private func makeMockPropertyCaptureVM(
    imageData: Data = .init(repeating: 0xFF, count: 1024),
    location: CLLocation = .init(latitude: 7.087357181983118, longitude: 125.66729262828807)
  ) -> (PropertyCaptureViewModel, GeocodingAPIMock, PropertyRepositoryMock) {
    let geocodingAPIMock = GeocodingAPIMock()
    let propertyRepositoryMock = PropertyRepositoryMock(properties: [])
    let sut = PropertyCaptureViewModel(
      imageData: imageData,
      currentLocation: location,
      geocodingAPI: geocodingAPIMock,
      propertyRepository: propertyRepositoryMock
    )

    return (sut, geocodingAPIMock, propertyRepositoryMock)
  }
}

// MARK: Make Stub

extension PropertyCaptureViewModelTest {

  private func makeStubReverseGeocodeResponse() -> ReverseGeocodeResponse {
    let address = Address(
      road: "Circumferential Road",
      quarter: nil,
      suburb: "Limao",
      city: "Samal",
      region: "Davao Region",
      postcode: "8119",
      country: "Philippines"
    )
    let reverseGeocode = ReverseGeocodeResponse(
      placeId: 261460442,
      name: "Crusoe Cabins at Costa Azalea",
      type: "beach_resort",
      address: address
    )

    return reverseGeocode
  }
}
