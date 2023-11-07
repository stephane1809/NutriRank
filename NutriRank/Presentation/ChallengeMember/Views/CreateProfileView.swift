//
//  CreateProfileView.swift
//  NutriRank
//
//  Created by Stephane Girão Linhares on 06/10/23.
//

import Foundation
import SwiftUI
import PhotosUI

public struct CreateProfileView: View {


    @ObservedObject var viewModel: FeedGroupViewModel

    init(viewModel: FeedGroupViewModel) {
        self.viewModel = viewModel
    }

    @State private var selectedImageProfile: UIImage? = UIImage(named: "avatar1")
    @State private var isImagePickerDisplay = false
    @State private var isImagePickerDisplay2 = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var nickName = ""

    @State private var showFailAlert = false
    @State private var showCloudPermissionAlert = false
    @State private var isLoading = false

    @State private var performNavigation: Bool = false

    public var body: some View {

        GeometryReader { metrics in
                ZStack {

                    if isLoading{
                        LoadingView()
                            .zIndex(1.0)
                    }

                    Color(.defaultBackground)
                        .ignoresSafeArea()

                    VStack (spacing: 70) {

                        VStack {
                            VStack {
                                Image(uiImage: selectedImageProfile!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .frame(width: 200, height: 200)

                                Button("Adicionar foto") {
                                    self.isImagePickerDisplay.toggle()
                                }
                                .padding()
                                .font(.headline)
                            }
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

                            VStack (spacing: 2) {

                                HStack {
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.primary)
                                    Text("Nome")
                                        .foregroundColor(.primary)
                                    Spacer()
                                }

                                TextField("Nome de usuário", text: $nickName)
                                    .foregroundColor(.gray)
                            }

                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .frame(maxWidth: metrics.size.width * 0.92, minHeight: metrics.size.height * 0.09)
                            .background(Color("TextFieldBoxColor"))
                            .cornerRadius(10)
                            .shadow(radius: 1, x: 0, y: 1)
                        }


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
                                }
                            }
                        } label: {
                            Text("Continuar")
                                .font(.headline)
                                .frame(width: 125, height: 35)
                                .foregroundColor(.white)
                        }
                        .background(Color("FirstPlaceRanking"))
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
                .navigationDestination(isPresented: $performNavigation, destination: { EmptyStateView(viewmodel: viewModel) })
            .navigationBarBackButtonHidden(true)
        }
    }
}
