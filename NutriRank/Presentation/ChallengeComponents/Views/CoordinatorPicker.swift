//
//  CordinatorPicker.swift
//  NutriRank
//
//  Created by Stephane Girão Linhares on 18/09/23.
//  Copyright © 2023 Merendeers. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class CoordinatorPicker: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePickerView

    init(picker: ImagePickerView) {
        self.picker = picker
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }

}
