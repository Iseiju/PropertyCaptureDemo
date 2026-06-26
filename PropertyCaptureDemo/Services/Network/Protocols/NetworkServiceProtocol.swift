//
//  NetworkServiceProtocol.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import Foundation

protocol NetworkServiceProtocol {

  func request<T: Codable>(
    api: NetworkAPIProtocol, type: T.Type, timeoutInterval: TimeInterval
  ) async throws -> T
}
