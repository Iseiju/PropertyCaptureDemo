//
//  AppError.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/27/26.
//

import Foundation

enum AppError: Error {
  case badURL
  case badServerResponse(message: String? = nil)
  case decodingError(message: String)
  case generic(String)
  case unknown

  var localizedDescription: String {
    switch self {
    case .badURL:
      return "Bad URL"

    case .badServerResponse(let message):
      guard let message,
            !message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
      else { return "Bad Server Response" }

      return message

    case .decodingError(let message):
      return message

    case .generic(let message):
      return message

    case .unknown:
      return "Unknown Error"
    }
  }

  var code: Int {
    switch self {
    case .badURL:
      return NSURLErrorBadURL

    case .badServerResponse:
      return NSURLErrorBadServerResponse

    case .decodingError:
      return NSURLErrorCannotDecodeContentData

    case .generic, .unknown:
      return NSURLErrorUnknown
    }
  }
}
