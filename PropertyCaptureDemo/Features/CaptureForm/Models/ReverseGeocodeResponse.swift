//
//  ReverseGeocodeResponse.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/27/26.
//

import Foundation

struct ReverseGeocodeResponse: Decodable {

  var placeId: Int
  var name: String
  var type: String
  var address: Address

  private enum CodingKeys: String, CodingKey {
    case placeId = "place_id"
    case name
    case type
    case address
  }
}
