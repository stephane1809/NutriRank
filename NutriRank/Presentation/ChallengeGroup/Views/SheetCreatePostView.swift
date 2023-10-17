//
//  SheetCreatePostView.swift
//  NutriRank
//
//  Created by Stephane Girão Linhares on 10/10/23.
//

import Foundation
import SwiftUI

public struct SheetCreatePostView: View {



    @Environment(\.dismiss) var dismiss
    let selectedImage: UIImage?
    @State private var title = ""
    @State private var description = ""

    public var body: some View {
        ZStack (alignment: .top) {
            Color(.defaultBackground)
                .ignoresSafeArea()
            VStack (spacing: 20) {
                HStack (spacing: 33) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancelar")
                    }

                    Text("Criar Postagem")
                        .fontWeight(.bold)
                        .font(.system(size: 20))

                    Button {

                    } label: {
                        Text("Postar")
                    }
                }
                .padding(.vertical, 18)

                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Rectangle())
                        .scaledToFill()
                        .frame(width: 330, height: 150)
                        .cornerRadius(10)

                } else {
                    Image(systemName: "camera.fill").font(.system(size: 37, weight: .regular))
                        .aspectRatio(contentMode: .fit)
                        .scaledToFill()
                        .frame(width: 330, height: 150)
                        .background(.blue)
                        .cornerRadius(10)
                }

                VStack (spacing: 2) {

                    HStack {
                        Image(systemName: "person.fill")
                        Text("Título")
                        Spacer()
                    }

                    TextField("Título da postagem", text: $title)
                }

                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .frame(maxWidth: 330, minHeight: 50)
                .background(.white)
                .cornerRadius(10)
                .shadow(radius: 1, x: 0, y: 1)

                VStack (spacing: 2) {

                    HStack {
                        Image(systemName: "person.fill")
                        Text("Descrição")
                        Spacer()
                    }

                    TextField("Descrição da postagem", text: $description)
                }

                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .frame(maxWidth: 330, minHeight: 50)
                .background(.white)
                .cornerRadius(10)
                .shadow(radius: 1, x: 0, y: 1)
            }

        }


    }
}
