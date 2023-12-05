//
//  ProfileView.swift
//  NutriRank
//
//  Created by Stephane Girão Linhares on 16/11/23.
//

import Foundation
import SwiftUI
import PhotosUI

struct ProfileView: View {

    @ObservedObject var viewModel: FeedGroupViewModel

    init(viewModel: FeedGroupViewModel) {
        self.viewModel = viewModel
    }

    @State private var editActive = false
    @State private var selectedImageProfile: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var isImagePickerDisplay2 = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var nickName: String = ""

    @State private var showFailAlert = false
    @State private var showCloudPermissionAlert = false
    @State private var isLoading = false

    @State private var performNavigation: Bool = false

    var body: some View {
        GeometryReader { metrics in
                ZStack {
                    Color(.defaultBackground)
                        .ignoresSafeArea()

                    VStack (spacing: 70) {

                        VStack {
                            VStack (spacing: 10){

                                if editActive == true {
                                    Image(uiImage: selectedImageProfile ?? viewModel.member.avatar!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                        .frame(width: 200, height: 200)

                                    Button("Alterar foto") {
                                        self.isImagePickerDisplay.toggle()
                                    }
                                    .font(.headline)
                                } else {
                                    Image(uiImage: viewModel.member.avatar!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                        .frame(width: 200, height: 200)
                                }

                            }
                            .padding(.vertical, 15)
                            .actionSheet(isPresented: $isImagePickerDisplay) {
                                ActionSheet(
                                    title: Text("Escolha uma opção"),
                                    buttons:[
                                        .default(
                                            Text("Câmera"),
                                            action: {
                                                self.sourceType = .camera
                                                self.isImagePickerDisplay2 = true
                                            }
                                        ),
                                        .default(
                                            Text("Galeria"),
                                            action: {
                                                if PHPhotoLibrary.authorizationStatus(for: .readWrite) == .authorized {
                                                    self.sourceType = .photoLibrary
                                                    self.isImagePickerDisplay2 = true
                                                } else {
                                                    PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                                                        if status == .authorized {
                                                            self.sourceType = .photoLibrary
                                                            self.isImagePickerDisplay2 = true
                                                        }
                                                    }
                                                }
                                            }
                                        ),
                                        .cancel()
                                    ]
                                )
                            }
                            .sheet(isPresented: self.$isImagePickerDisplay2) {
                                ImagePickerView(selectedImage: self.$selectedImageProfile, sourceType: self.sourceType)
                            }

                            VStack (alignment: .leading, spacing: 2) {
                                HStack {
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.primary)
                                    Text("Nome")
                                        .foregroundColor(.primary)
                                    Spacer()
                                }
                                if editActive == true {
                                    TextField("nome de usuário", text: $nickName)

                                } else {
                                    Text(viewModel.member.name)
                                }

                            }

                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .frame(maxWidth: metrics.size.width * 0.92, minHeight: metrics.size.height * 0.09)
                            .background(Color("TextFieldBoxColor"))
                            .cornerRadius(10)
                            .shadow(radius: 1, x: 0, y: 1)
                        }

                        if editActive == true {
                            Button {
                                Task{
                                    if nickName == "" || selectedImageProfile == nil {
                                        self.showFailAlert = true

                                    } else {
                                        self.isLoading = true
                                        if await viewModel.createChallengeMember(name:nickName,avatar: selectedImageProfile!,score:0) {
                                            UserDefaults.standard.set(true, forKey: "isFirstTimeUsingApp")
                                            self.isLoading.toggle()
                                            self.performNavigation.toggle()
                                        } else {
                                            self.isLoading = false
                                            self.showCloudPermissionAlert = true
                                        }
                                        self.editActive.toggle()
                                    }
                                }
                            } label: {
                                Text("Concluir")
                                    .font(.headline)
                                    .frame(width: 125, height: 35)
                                    .foregroundColor(.white)
                            }
                            .background(Color("actionButton"))
                            .cornerRadius(10)
                            .buttonStyle(.bordered)
                            .alert("Insira uma imagem e um nome para criar seu usuário", isPresented: $showFailAlert) {
                                Button("Ok", role: .cancel) {}
                            }
                            .alert("Entre com sua conta Apple nas configurações do seu aparelho para prosseguir com a criação de usuário", isPresented: $showCloudPermissionAlert) {
                                Button("Ok", role: .cancel) {}
                            }
                        }

                    }
                }
//                .toolbar {
//                    ToolbarItem(placement: .topBarTrailing) {
//                        Button(action: {
//                            editActive.toggle()
//                        }) {
//                            if editActive == false{
//                                Text("Editar")
//                            } else {
//                                Button(action: {
//                                    editActive.toggle()
//                                    selectedImageProfile = viewModel.member.avatar
//                                    nickName = viewModel.member.name
//                                }){
//                                    Text("Cancelar")
//                                }
//
//                            }
//                        }
//                    }
//                }
                .navigationDestination(isPresented: $performNavigation, destination: { EmptyStateView(viewmodel: viewModel) })
        }
    }
}
