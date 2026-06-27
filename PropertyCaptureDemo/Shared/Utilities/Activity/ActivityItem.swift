//
//  ActivityItem.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/27/26.
//

import LinkPresentation
import UIKit

final class ActivityItem: NSObject, UIActivityItemSource {

  private let imageData: Data
  private let title: String
  private let subtitle: String

  private var image: UIImage? {
    return UIImage(data: imageData)
  }

  init(imageData: Data, title: String, subtitle: String) {
    self.imageData = imageData
    self.title = title
    self.subtitle = subtitle
  }

  func activityViewControllerPlaceholderItem(
    _ activityViewController: UIActivityViewController
  ) -> Any {
    return image ?? UIImage()
  }

  func activityViewController(
    _ activityViewController: UIActivityViewController,
    itemForActivityType activityType: UIActivity.ActivityType?
  ) -> Any? {
    return image
  }

  func activityViewControllerLinkMetadata(
    _ activityViewController: UIActivityViewController
  ) -> LPLinkMetadata? {
    guard let image else { return nil }

    let metadata = LPLinkMetadata()
    metadata.imageProvider = NSItemProvider(object: image)
    metadata.title = title
    metadata.originalURL = URL(fileURLWithPath: subtitle)

    return metadata
  }
}
