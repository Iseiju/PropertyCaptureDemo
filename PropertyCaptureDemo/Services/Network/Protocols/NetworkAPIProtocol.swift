//
//  NetworkAPIProtocol.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import Foundation

protocol NetworkAPIProtocol {

  var method: NetworkMethod { get }
  var host: String { get }
  var endpoint: String { get }
  var queryParams: [String : Any]? { get }
}

extension NetworkAPIProtocol {

  func createURL() -> URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    components.path = endpoint

    if let queryParams {
      components.queryItems = queryParams.toQueryItem()
    }

    return components.url
  }
  
  private func createHeaders() -> [String : String] {
    if let bundle = Bundle.main.bundleIdentifier {
      return ["User-Agent" : bundle]
    }

    return [:]
  }
}
