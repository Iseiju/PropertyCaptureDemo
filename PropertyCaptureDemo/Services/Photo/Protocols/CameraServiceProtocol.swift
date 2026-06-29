//
//  CameraServiceProtocol.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/29/26.
//

import AVFoundation

protocol CameraServiceProtocol {

  var isAuthorized: Bool { get }

  func requestCameraAuthorization() async
}
