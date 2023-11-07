//
//  CopyToClipboardView.swift
//  NutriRank
//
//  Created by Paulo Henrique Gomes da Silva on 07/11/23.
//

import SwiftUI
import Foundation

struct CopyToClipboardView: View {
    @Binding private var enabled: Bool
    @State private var copyMessageOpacity: Double = 0.0

    init(enabled: Binding<Bool>) {
        self._enabled = enabled
    }

    var body: some View {
        Text("Copied to clipboard")
            .foregroundStyle(.primary)
            .padding()
            .background(Color.defaultCard.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 11))
            .opacity(copyMessageOpacity)
            .animation(.easeInOut(duration: 0.5), value: copyMessageOpacity)
            .onChange(of: enabled) { newValue in
                if newValue {
                    Task {
                        copyMessageOpacity = 1
                        try? await Task.sleep(for: .seconds(2))
                        copyMessageOpacity = 0
                        enabled = false
                    }
                }
            }
    }
}

