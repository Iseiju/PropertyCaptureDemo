//
//  HomeViewModel.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import Foundation

@Observable
final class HomeViewModel {

  var properties: [Property] = []

  var capturedImageData: Data? = nil
  var isImagePickerPresented: Bool = false

  private let propertyRepository: PropertyRepository

  init(_ propertyRepository: PropertyRepository) {
    self.propertyRepository = propertyRepository
  }
}

// MARK: Property Functions

extension HomeViewModel {

  func getProperties() async throws {
    do {
      properties = try await propertyRepository.getProperties()
    } catch {
      throw error
    }
  }
}
