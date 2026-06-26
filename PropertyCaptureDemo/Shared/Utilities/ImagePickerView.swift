//
//  ImagePickerView.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {

  @Binding var image: UIImage?

  @Environment(\.dismiss) private var dismiss

  func makeCoordinator() -> Coordinator {
    return Coordinator(self)
  }

  func makeUIViewController(context: Context) -> some UIViewController {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .camera
    imagePicker.cameraFlashMode = .auto
    imagePicker.delegate = context.coordinator

    return imagePicker
  }

  func updateUIViewController(
    _ uiViewController: UIViewControllerType, context: Context
  ) {}

  class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let parent: ImagePickerView

    init(_ parent: ImagePickerView) {
      self.parent = parent
    }

    func imagePickerController(
      _ picker: UIImagePickerController,
      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
      guard let image = info[.originalImage] as? UIImage else { return }

      parent.image = image
      parent.dismiss()
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      parent.dismiss()
    }
  }
}
