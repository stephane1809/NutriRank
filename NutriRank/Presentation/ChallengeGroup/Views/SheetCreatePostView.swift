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
    @ObservedObject var viewmodel: FeedGroupViewModel
    @Binding var selectedImage: UIImage?
    @State private var title = ""
    @State private var description = ""
    @State private var showAlert: Bool = false

    public init(viewmodel: FeedGroupViewModel, selectedImage: Binding<UIImage?>) {
        self.viewmodel = viewmodel
        self._selectedImage = selectedImage
    }

    public var body: some View {

        NavigationStack {
            ZStack (alignment: .top) {
                Color(.defaultBackground)
                    .ignoresSafeArea()
                VStack (spacing: 20) {
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
                }.toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Postar") {
                            Task {
                                let result = await viewmodel.createPost(title: self.title, description: self.description, postImage: self.selectedImage)
                                if !result {
                                    showAlert.toggle()
                                }
                                await viewmodel.updateChallengeMember()
                            }
                        }.alert("Erro ao criar post!", isPresented: $showAlert) {
                            Button("cancelar", role: .cancel){}
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
