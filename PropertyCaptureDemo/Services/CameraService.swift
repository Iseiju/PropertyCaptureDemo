//
//  CameraService.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import AVFoundation

protocol CameraServiceProtocol {

  var authStatus: AVAuthorizationStatus { get }

  func requestPermission() async
}

final class CameraService: CameraServiceProtocol {

  var authStatus: AVAuthorizationStatus {
    return AVCaptureDevice.authorizationStatus(for: .video)
  }

  func requestPermission() async {
    await AVCaptureDevice.requestAccess(for: .video)
  }
}
