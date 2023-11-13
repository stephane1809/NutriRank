//
//  SheetCreatePostView.swift
//  NutriRank
//
//  Created by Stephane Girão Linhares on 10/10/23.
//

import Foundation
import SwiftUI
import Mixpanel

public struct SheetCreatePostView: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewmodel: FeedGroupViewModel
    @Binding var selectedImage: UIImage?
    @State private var title = ""
    @State private var description = ""
    @State private var showAlert: Bool = false

    @State private var isLoading: Bool = false
    @State private var showPermissionAlert: Bool = false
    @State private var isPostButtonHidden: Bool = false
    @State private var isCancelButtonHidden: Bool = false

    public init(viewmodel: FeedGroupViewModel, selectedImage: Binding<UIImage?>) {
        self.viewmodel = viewmodel
        self._selectedImage = selectedImage
    }

    public var body: some View {

        NavigationStack {
            ZStack (alignment: .top) {

                if isLoading {
                    LoadingView()
                        .zIndex(1.0)
                }

                Color(.defaultBackground)
                    .ignoresSafeArea()
                VStack (spacing: 20) {
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Rectangle())
                            .scaledToFill()
                            .frame(width: 330, height: 300)
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
                                .foregroundColor(.black)
                            Text("Título")
                                .foregroundColor(.black)
                            Spacer()
                        }

                        TextField("Título da postagem", text: $title)
                            .foregroundColor(.black)
                    }

                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .frame(maxWidth: 330, minHeight: 50)
                    .background(Color("FeedGroupHeaderColor"))
                    .cornerRadius(10)
                    .shadow(radius: 1, x: 0, y: 1)

                    VStack (spacing: 2) {

                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.black)
                            Text("Descrição")
                                .foregroundColor(.black)
                            Spacer()
                        }

                        TextField("Descrição da postagem", text: $description)
                            .foregroundColor(.black)
                    }

                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .frame(maxWidth: 330, minHeight: 50)
                    .background(Color("FeedGroupHeaderColor"))
                    .cornerRadius(10)
                    .shadow(radius: 1, x: 0, y: 1)
                }.toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Postar") {
                            Task {
                                Mixpanel.mainInstance().track(event: "Created a Post", properties: MixpanelProductionIndicator.Production.retrieveDict())
                                if title == "" || description == "" || selectedImage == nil {
                                    self.showPermissionAlert = true
                                } else {
                                    self.isLoading = true
                                    self.isPostButtonHidden = true
                                    self.isCancelButtonHidden = true
                                    let result = await viewmodel.createPost(title: self.title, description: self.description, postImage: self.selectedImage)
                                    if !result {
                                        showAlert.toggle()
                                    }
                                    await viewmodel.updateChallengeMember()
                                    dismiss()
                                }
                            }
                        }
                        .opacity(isPostButtonHidden ? 0 : 1)
                        .alert("Erro ao criar post!", isPresented: $showAlert) {
                            Button("cancelar", role: .cancel){}
                        }
                        .alert("Preencha todos os campos para criar seu post", isPresented: $showPermissionAlert){
                            Button("ok", role: .cancel){}
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") {
                            dismiss()
                        }
                        .opacity(isCancelButtonHidden ? 0 : 1)
                    }
                }
            }
            .onAppear{
                Mixpanel.mainInstance().track(event: "Create Post View", properties: MixpanelProductionIndicator.Production.retrieveDict())
            }
        }
    }
}
