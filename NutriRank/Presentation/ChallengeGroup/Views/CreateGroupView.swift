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
    @State private var selectDateInit: Date = Date()
    @State private var selectDateFinal: Date = Date()
    @State var showFailAlert: Bool = false

    init(viewmodel: FeedGroupViewModel) {
        self.viewmodel = viewmodel
    }


    public var body: some View {

        GeometryReader { metrics in
            NavigationView {
                    ScrollView {
                        VStack (spacing: 40) {
                            VStack(spacing: 1) {
                                if selectedImage != nil {
                                    Image(uiImage: selectedImage!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(Rectangle())
                                        .scaledToFill()
                                        .frame(width: metrics.size.width * 0.92, height: metrics.size.height * 0.20)
                                        .cornerRadius(10)
//                                        .containerRelativeFrame([.horizontal])
                                } else {
                                    Image(systemName: "camera.fill").font(.system(size: 37, weight: .regular))
                                        .aspectRatio(contentMode: .fit)
                                        .scaledToFill()
                                        .frame(width: metrics.size.width * 0.92, height: metrics.size.height * 0.20)
//                                        .background(Color("Green"))
                                        .cornerRadius(10)
                                }

                                Button("Adicionar imagem") {
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
                                        Image(systemName: "pencil")
                                        Text("Descrição")
                                        Spacer()
                                    }

                                    TextField("Descrição do grupo", text: $description)
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
                                    DatePicker("Início:", selection: $selectDateInit)
                                    Spacer()
                                    DatePicker("Fim:", selection: $selectDateFinal)

                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .frame(maxWidth: metrics.size.width * 0.92, minHeight: metrics.size.height * 0.09)
                                .background(.background)
                                .cornerRadius(10)
                                .shadow(radius: 1, x: 0, y: 1)

                                VStack (spacing: 2){

                                    HStack {
                                        Image(systemName: "flame.fill")
                                        Text("Regras")
                                        Spacer()
                                    }
//                                    TextField("Regras do grupo", text: $rulesGroup, axis: .vertical)
//                                        .lineLimit(1...10)
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

                                        if groupName == "" || description == "" || selectedImage == nil {
                                            self.showFailAlert = true
                                        } else{
                                            await viewmodel.createGroup(groupName: self.groupName, description: self.description, image: selectedImage)
                                        }
                                    }
                                } label: {
                                    Text("Criar grupo")
                                        .font(.headline)
                                        .frame(width: 125, height: 35)
                                        .foregroundColor(.white)
                                }
                                .background(.blue)
                                .cornerRadius(10)
                                .buttonStyle(.bordered)
                                .alert("Preencha todos os campos para criar seu grupo", isPresented: $showFailAlert) {
                                    Button("Ok", role: .cancel) {}
                                }

                            }
                            .frame(maxWidth: .infinity)
                            Spacer()
                        }

                    }
                    .frame(maxWidth: .infinity)
                    .background(Color("Light blue"))
                    .onTapGesture {
                        self.hideKeyboard()
                    }
                    .navigationTitle("Criar grupo")
                }
        }

        .navigationViewStyle(.stack)

    }

}
