//
//  CreateGroupView.swift
//  NutriRankUI
//
//  Created by Stephane Girão Linhares on 19/09/23.
//  Copyright © 2023 Merendeers. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit



public struct CreateGroupView: View {

    @ObservedObject var viewmodel: FeedGroupViewModel

    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var isImagePickerDisplay2 = false
    @State private var groupName: String = ""
    @State private var description: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var duration: Int = 0
    @State private var calendar: Calendar = Calendar(identifier: .gregorian)
    @State private var showFailAlert: Bool = false
    @State private var showCloudPermissionAlert: Bool = false
    @State private var isLoading: Bool = false

    @State private var performNavigation: Bool = false



    init(viewmodel: FeedGroupViewModel) {
        self.viewmodel = viewmodel
    }


    public var body: some View {


        GeometryReader { metrics in

            if isLoading {
                LoadingView()
                    .zIndex(1.0)
                    .navigationBarBackButtonHidden(true)
            }

                ScrollView {
                        VStack (spacing: 30) {

                            VStack(spacing: 1) {
                                if selectedImage != nil {
                                    Image(uiImage: selectedImage!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(Rectangle())
                                        .scaledToFill()
                                        .frame(width: metrics.size.width * 0.92, height: metrics.size.height * 0.20)
                                        .cornerRadius(10)
                                } else {
                                    Image(systemName: "camera.fill").font(.system(size: 37, weight: .regular))
                                        .aspectRatio(contentMode: .fit)
                                        .scaledToFill()
                                        .frame(width: metrics.size.width * 0.92, height: metrics.size.height * 0.20)
                                        .background(Color("DefaultCardColor"))
                                        .cornerRadius(10)
                                }

                                Button("Adicionar imagem") {
                                    self.isImagePickerDisplay.toggle()
                                }
                                .padding()
                                .font(.headline)

                            }
                            .padding(.top, 10)
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
                                                self.sourceType = .photoLibrary
                                                self.isImagePickerDisplay2 = true
                                            }
                                        ),
                                        .cancel()
                                    ]
                                )
                            }
                            .sheet(isPresented: self.$isImagePickerDisplay2) {
                                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                            }

                            VStack (spacing: 20) {

                                VStack (spacing: 2) {

                                    HStack {
                                        Image(systemName: "person.2.fill")
                                        Text("Grupo")
                                        Spacer()
                                    }

                                    TextField("Nome do grupo", text: $groupName)
                                }

                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .frame(maxWidth: metrics.size.width * 0.92, minHeight: metrics.size.height * 0.09)
                                .background(.background)
                                .cornerRadius(10)
                                .shadow(radius: 1, x: 0, y: 1)

                                VStack (spacing: 2) {

                                    HStack {
                                        Image(systemName: "flame.fill")
                                        Text("Desafio")
                                        Spacer()
                                    }

                                    TextField("Ex: comer uma fruta todo dia..", text: $description)
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .frame(maxWidth: metrics.size.width * 0.92, minHeight: metrics.size.height * 0.09)
                                .background(.background)
                                .cornerRadius(10)
                                .shadow(radius: 1, x: 0, y: 1)

                                VStack (spacing: 2){

                                    HStack {
                                        Image(systemName: "stopwatch.fill")
                                        Text("Duração")
                                        Spacer()
                                    }
                                    DatePicker("Início:", selection: $startDate, displayedComponents: [.date])
                                    Spacer()
                                    DatePicker("Fim:", selection: $endDate, displayedComponents: [.date])

                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .frame(maxWidth: metrics.size.width * 0.92, minHeight: metrics.size.height * 0.09)
                                .background(.background)
                                .cornerRadius(10)
                                .shadow(radius: 1, x: 0, y: 1)

                                Spacer()

                                Button {

                                    Task {

                                        duration = calendar.numberOfDaysBetween(start: startDate, end: endDate)
                                        if groupName == "" || description == "" || selectedImage == nil {
                                            self.showFailAlert = true
                                        } else{
                                            self.isLoading = true
                                            if await viewmodel.createGroup(groupName: self.groupName, description: self.description, image: selectedImage, startDate: startDate, endDate: endDate, duration: duration) {
                                                self.performNavigation = true
                                            } else {
                                                self.isLoading = false
                                                self.showCloudPermissionAlert = true
                                            }
                                        }
                                    }
                                } label: {
                                    Text("Criar grupo")
                                        .font(.headline)
                                        .frame(width: 125, height: 35)
                                        .foregroundColor(.white)
                                }
                                .background(Color("FirstPlaceRanking"))
                                .cornerRadius(10)
                                .buttonStyle(.bordered)
                                .alert("Preencha todos os campos para criar seu grupo", isPresented: $showFailAlert) {
                                    Button("Ok", role: .cancel) {}
                                }
                                .alert("Entre com sua conta Apple, nas configurações do seu aparelho, para prosseguir com a criação de grupo", isPresented: $showCloudPermissionAlert) {
                                    Button("Ok", role: .cancel) {}
                                }

                                NavigationLink("", destination: FeedPostView(viewmodel: viewmodel), isActive: $performNavigation)
                                    .hidden()

                            }
                            .frame(maxWidth: .infinity)
                            Spacer()
                        }

                    }
                    .frame(maxWidth: .infinity)

                    .background(Color(.defaultBackground))
                    .onTapGesture {
                        self.hideKeyboard()
                    }

            .navigationTitle("Criar grupo")
        }

        .navigationViewStyle(.stack)

    }

}
