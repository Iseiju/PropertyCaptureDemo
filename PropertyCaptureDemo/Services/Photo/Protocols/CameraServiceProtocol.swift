//
//  CameraServiceProtocol.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/29/26.
//

import AVFoundation

protocol CameraServiceProtocol {

  var authStatus: AVAuthorizationStatus { get }

  func requestCameraAuthorization() async
}
