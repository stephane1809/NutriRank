//
//  FeedPostView.swift
//  NutriRank
//
//  Created by Stephane Girão Linhares on 09/10/23.
//

import Foundation
import SwiftUI

public struct FeedPostView: View {

    enum Sheet: Identifiable {
        case selection
        case image

        var id: Sheet { self }

    }

    public init() {}

    @State var card = CardPostView()
    @State private var isImagePickerDisplay = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay2 = false
    @State private var isPostCardDisplay = false
    @State private var isImageExist = false

    @State private var sheet: Sheet?

    public var body: some View {
        GeometryReader { metrics in
            NavigationView  {
                ZStack {
                    Color(.defaultBackground)
                        .ignoresSafeArea()
                    VStack (alignment: .center, spacing: 20){
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
//                            sheet = .selection
                        } label: {
                            Text("+ Nova Postagem")
                                .font(.headline)
                                .frame(width: 250, height: 35)
                                .foregroundColor(.white)
                        }
                        .background(Color("FirstPlaceRanking"))
                        .cornerRadius(10)
                        .buttonStyle(.bordered)

                        VStack {
                            Text("Postagens")
                            ScrollView {
                                Button {
                                    self.isPostCardDisplay.toggle()
                                } label: {
                                    card
                                }

                            }
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
                                        self.sheet = .selection
                                    }
                                ),
                                .default(
                                    Text("Galeria"),
                                    action: {
                                        self.sourceType = .photoLibrary
                                        self.sheet = .selection
                                    }
                                ),
                                .cancel()
                            ]
                        )
                    }
                    .onChange(of: selectedImage) { selectedImage in
                        if selectedImage != nil {
                            sheet = .image
                        }
                    }
                    .sheet(item: $sheet) { sheet in
                        switch sheet {
                            case .image:
                            SheetCreatePostView()
                            case .selection:
                            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                        }
                    }
                }
            }
        }
    }
}
