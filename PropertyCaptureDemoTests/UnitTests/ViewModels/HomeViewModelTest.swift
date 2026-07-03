//
//  HomeViewModelTest.swift
//  PropertyCaptureDemoTests
//
//  Created by Kenneth James Uy on 7/3/26.
//

import CoreLocation
import XCTest
@testable import PropertyCaptureDemo

@MainActor
final class HomeViewModelTest: XCTestCase {
  
  func testGetPropertiesPopulatesProperties() async {
    let stubProperties = makeStubProperties()
    let (sut, _, _, _) = makeMockHomeVM(properties: stubProperties)
    
    sut.getProperties()
    
    XCTAssertFalse(sut.properties.isEmpty)
    XCTAssertEqual(sut.properties, stubProperties)
  }
  
  func testStartUpdatingLocationAndSetCurrentLocation() async {
    let stubLocations = makeStubLocations()
    let (sut, locationMock, _, _) = makeMockHomeVM(locations: stubLocations)

    sut.startUpdatingLocation()

    XCTAssertTrue(locationMock.didStartUpdating)
    XCTAssertNotNil(sut.currentLocation)
    XCTAssertEqual(sut.currentLocation, stubLocations.last)
  }

  func testStopUpdatingLocationAndSetCurrentLocation() async {
    let stubLocations = makeStubLocations()
    let (sut, locationMock, _, _) = makeMockHomeVM(locations: stubLocations)

    sut.startUpdatingLocation()
    sut.stopUpdatingLocation()

    XCTAssertTrue(locationMock.didStopUpdating)
  }

  func testStartUpdatingLocationWithNoLocations() async {
    let (sut, locationMock, _, _) = makeMockHomeVM()

    sut.startUpdatingLocation()

    XCTAssertTrue(locationMock.didStartUpdating)
    XCTAssertNil(sut.currentLocation)
  }
}

// MARK: Make SUT

extension HomeViewModelTest {

  private func makeMockHomeVM(
    locations: [CLLocation] = [], properties: [Property] = []
  ) -> (
    HomeViewModel,
    LocationServiceMock,
    CameraServiceMock,
    PropertyRepositoryMock
  ) {
    let locationMock = LocationServiceMock(locations: locations)
    let cameraMock = CameraServiceMock()
    let repositoryMock = PropertyRepositoryMock(properties: properties)
    let sut = HomeViewModel(
      locationService: locationMock,
      cameraService: cameraMock,
      propertyRepository: repositoryMock
    )

    return (sut, locationMock, cameraMock, repositoryMock)
  }
}

// MARK: Make Stub

extension HomeViewModelTest {

  private func makeStubProperties() -> [Property] {
    return [
      .init(
        imageData: Data(repeating: 0xFF, count: 1022),
        name: "Sunset Villa",
        type: "House",
        address: "123 Maple Street, Springfield",
        notes: "Sample Notes"
      ),
      .init(
        imageData: Data(repeating: 0xFF, count: 1023),
        name: "Downtown Loft",
        type: "Apartment",
        address: "456 Main Avenue, Metro City",
        notes: "Sample Notes"
      ),
      .init(
        imageData: Data(repeating: 0xFF, count: 1024),
        name: "Lakeside Cottage",
        type: "Cottage",
        address: "789 Lakeview Drive, Greenfield",
        notes: "Sample Notes"
      )
    ]
  }

  private func makeStubLocations() -> [CLLocation] {
    return [
      .init(latitude: 7.07305, longitude: 125.61285),
      .init(latitude: 7.07420, longitude: 125.61410),
      .init(latitude: 7.07560, longitude: 125.61580)
    ]
  }
}
