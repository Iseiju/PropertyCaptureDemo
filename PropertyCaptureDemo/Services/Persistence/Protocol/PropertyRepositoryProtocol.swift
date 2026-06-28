//
//  PropertyRepositoryProtocol.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/27/26.
//

import Foundation

protocol PropertyRepositoryProtocol {

  func getProperties() throws -> [Property]
  func getProperty(for uuid: UUID) throws -> Property?
  func insert(_ property: Property) throws
  func save() throws
}
