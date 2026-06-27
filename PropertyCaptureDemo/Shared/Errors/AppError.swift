//
//  AppError.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/27/26.
//

import Foundation

enum AppError: Error {
  case invalidURL
  case badServerResponse(message: String? = nil)
  case generic(String)

  var localizedDescription: String {
    switch self {
    case .invalidURL:
      return "Invalid URL"

    case .badServerResponse(let message):
      guard let message,
            !message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
      else { return "Bad Server Response" }

      return message

    case .generic(let message):
      return message
    }
  }

  var code: Int {
    switch self {
    case .invalidURL:
      return NSURLErrorBadURL

    case .badServerResponse:
      return NSURLErrorBadServerResponse

    case .generic:
      return NSURLErrorUnknown
    }
  }
}
