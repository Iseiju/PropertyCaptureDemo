//
//  Address.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/27/26.
//

import Foundation

struct Address: Decodable {

  var road: String
  var quarter: String
  var suburb: String
  var city: String
  var region: String
  var postcode: String
  var country: String

  static func dummyData() -> Self {
    return Self(
      road: "Test Road",
      quarter: "Test Quarter",
      suburb: "Test Suburb",
      city: "Test City",
      region: "Test Region",
      postcode: "Test Postcode",
      country: "Test Country"
    )
  }
}
