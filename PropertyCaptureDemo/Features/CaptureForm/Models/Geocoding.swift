//
//  Geocoding.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/27/26.
//

import Foundation

struct Geocoding: Decodable {

  var placeId: Int
  var name: String
  var type: String
  var address: Address
}
