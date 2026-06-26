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
}
