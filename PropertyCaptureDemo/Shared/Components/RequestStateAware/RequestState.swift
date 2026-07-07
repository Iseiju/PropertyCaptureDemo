//
//  RequestState.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 7/7/26.
//

import Foundation

enum RequestState {
  case idle
  case loading
  case loaded
  case failed(AppError)

  var isRequesting: Bool {
    switch self {
    case .idle, .loaded, .failed:
      return false

    case .loading:
      return true
    }
  }
}
