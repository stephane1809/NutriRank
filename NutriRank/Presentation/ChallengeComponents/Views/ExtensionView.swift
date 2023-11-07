//
//  ExtensionView.swift
//  NutriRankUI
//
//  Created by Stephane Girão Linhares on 22/09/23.
//  Copyright © 2023 Merendeers. All rights reserved.
//

import Foundation
import SwiftUI

#if canImport(UIKit)

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#endif
