//
//  UIApplication+Extension.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import UIKit

extension UIApplication {

  func endEditing() {
    sendAction(
      #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil
    )
  }

  func openSettings() {
    if let url = URL(string: UIApplication.openSettingsURLString) {
      if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
    }
  }
}
