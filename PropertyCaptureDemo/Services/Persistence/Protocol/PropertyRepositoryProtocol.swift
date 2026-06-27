//
//  PropertyRepositoryProtocol.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/27/26.
//

protocol PropertyRepositoryProtocol {

  func getProperties() async throws -> [Property]
  func save(_ property: Property) throws
}
