//
//  String+Extension.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/27/26.
//

import Foundation

extension String {

  nonisolated var isBlank: Bool {
    return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }

  var withoutSpaces: String {
    return trimmingCharacters(in: .whitespacesAndNewlines)
      .replacingOccurrences(of: " ", with: "")
  }
}
