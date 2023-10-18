//
//  LoadingView.swift
//  NutriRank
//
//  Created by Gabriel Santiago on 18/10/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack{
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)

            ProgressView("Carregando...")
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
        }
    }
}

#Preview {
    LoadingView()
}
