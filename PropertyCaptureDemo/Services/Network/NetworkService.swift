//
//  NetworkService.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import Foundation

class NetworkService: NetworkServiceProtocol {

  static let shared = NetworkService()

  func request<T: Decodable>(
    api: NetworkAPIProtocol, type: T.Type, timeoutInterval: TimeInterval = 4.0
  ) async throws -> T {
    do {
      guard let url = api.createURL() else { throw AppError.invalidURL }

      var request = URLRequest(url: url)
      request.httpMethod = api.method.rawValue.uppercased()
      request.timeoutInterval = timeoutInterval

      let (data, response) = try await URLSession.shared.data(for: request)

      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
      else {
        throw AppError
          .badServerResponse(message: String(data: data, encoding: .utf8))
      }

      return try JSONDecoder().decode(type, from: data)
    } catch {
      throw error
    }
  }
}
