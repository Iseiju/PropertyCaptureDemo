//
//  ActivityView.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/27/26.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {

  var items: [Any] = []

  func makeUIViewController(context: Context) -> some UIViewController {
    return UIActivityViewController(
      activityItems: items, applicationActivities: nil
    )
  }

  func updateUIViewController(
    _ uiViewController: UIViewControllerType, context: Context
  ) {}
}
