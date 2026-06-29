//
//  CameraService.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import AVFoundation

final class CameraService: CameraServiceProtocol {

  var authStatus: AVAuthorizationStatus {
    return AVCaptureDevice.authorizationStatus(for: .video)
  }

  func requestCameraAuthorization() async {
    guard authStatus == .notDetermined else { return }

    await AVCaptureDevice.requestAccess(for: .video)
  }
}
