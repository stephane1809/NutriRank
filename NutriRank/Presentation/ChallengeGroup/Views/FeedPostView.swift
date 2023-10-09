//
//  FeedPostView.swift
//  NutriRank
//
//  Created by Stephane Girão Linhares on 09/10/23.
//

import Foundation
import SwiftUI

public struct FeedPostView: View {

    public init() {}

    @State var card = CardPostView()
    @State private var isImagePickerDisplay = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay2 = false

    public var body: some View {
        GeometryReader { metrics in
            NavigationView  {
                ZStack {
                    Color(.defaultBackground)
                        .ignoresSafeArea()
                    VStack (alignment: .center){
                        ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 350, height: 137)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 7)
                                                .stroke(Color.black, lineWidth: 1.5)
                                        )
                                        .foregroundColor(.clear)

                                    HStack{
                                        Text("Nutrirankers")
                                            .fontWeight(.bold)
                                            .lineLimit(1)
                                        Spacer()
                                    }
                                    .frame(width: 320)
                                    .offset(x: 0, y: -40)

                                    HStack{
                                        Image(systemName: "flame.fill")
                                        Text("Top 3:")
                                            .bold()
                                        Text("Marcos, levi, leticia")
                                        Spacer()
                                    }
                                    .frame(width: 320)
                                    .offset(x: 0, y: -3)

                                    HStack{
                                        Image(systemName: "clock")
                                        Text("32 dias restates")
                                        Spacer()
                                    }
                                    .frame(width: 320)
                                    .offset(x: 0, y: 28)
                                }
                        Button {
                            self.isImagePickerDisplay.toggle()
                        } label: {
                            Text("+ Nova Postagem")
                                .font(.headline)
                                .frame(width: 250, height: 35)
                                .foregroundColor(.white)
                        }
                        .background(Color("FirstPlaceRanking"))
                        .cornerRadius(10)
                        .buttonStyle(.bordered)

                        Text("Postagens")
                        ScrollView {
                            card
                        }

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
                }
            }
        }
    }
}
