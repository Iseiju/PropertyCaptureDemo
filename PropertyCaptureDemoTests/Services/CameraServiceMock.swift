//
//  CameraServiceMock.swift
//  PropertyCaptureDemoTests
//
//  Created by Kenneth James Uy on 7/3/26.
//

@testable import PropertyCaptureDemo

final class CameraServiceMock: CameraServiceProtocol {

  private(set) var isAuthorized: Bool = false

  private(set) var didRequestAuthorization = false

  func requestCameraAuthorization() async {
    didRequestAuthorization = true
    isAuthorized = true
  }
}
