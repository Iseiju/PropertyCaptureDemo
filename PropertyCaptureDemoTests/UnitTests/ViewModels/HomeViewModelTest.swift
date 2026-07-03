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
    let properties: [Property] = [
      .init(
        imageData: Data(),
        name: "Sunset Villa",
        type: "House",
        address: "123 Maple Street, Springfield",
        notes: "Sample Notes"
      ),
      .init(
        imageData: Data(),
        name: "Downtown Loft",
        type: "Apartment",
        address: "456 Main Avenue, Metro City",
        notes: "Sample Notes"
      ),
      .init(
        imageData: Data(),
        name: "Lakeside Cottage",
        type: "Cottage",
        address: "789 Lakeview Drive, Greenfield",
        notes: "Sample Notes"
      )
    ]
    let (sut, _, _, _) = makeMockHomeVM(properties: properties)

    sut.getProperties()

    XCTAssertFalse(sut.properties.isEmpty)
    XCTAssertEqual(sut.properties, properties)
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
