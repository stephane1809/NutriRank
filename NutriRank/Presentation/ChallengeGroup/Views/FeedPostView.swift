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

    @ObservedObject var viewmodel: FeedGroupViewModel

    public init(viewmodel: FeedGroupViewModel) {
        self.viewmodel = viewmodel
    }

//    public init() {}

    @State private var isImagePickerDisplay = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay2 = false
    @State private var isPostCardDisplay = false
    @State private var isImageExist = false
    @State private var calendar: Calendar = Calendar(identifier: .gregorian)
    @State private var todayDate = Date.now
    @State private var performNavigation: Bool = false

    @State private var sheet: Sheet?

    public var body: some View {
        GeometryReader { metrics in
            NavigationView {
                ZStack {
                    Color(.defaultBackground)
                        .ignoresSafeArea()
                    VStack (alignment: .center, spacing: 20) {

                        Button {
                            self.performNavigation = true
                        } label: {
                            ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 350, height: 137)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 7)
//                                                    .stroke(Color.black, lineWidth: 1.5)
                                            )
                                            .foregroundColor(Color("DefaultRankingCellColor"))
                                            .shadow(radius: 1, x: 0, y: 1)

                                        HStack{
                                            Text(viewmodel.group.groupName)
                                                .fontWeight(.bold)
                                                .lineLimit(1)
                                                .foregroundColor(.black)
                                            Spacer()
                                        }
                                        .frame(width: 320)
                                        .offset(x: 0, y: -40)

                                        HStack{
                                            Image(systemName: "flame.fill")
                                                .foregroundColor(.black)
                                            Text("Top 3:")
                                                .bold()
                                                .foregroundColor(.black)
                                            Text("\(viewmodel.getNamePersonRanking(index: 0)), \(viewmodel.getNamePersonRanking(index: 1)), \(viewmodel.getNamePersonRanking(index: 2))")
                                                .foregroundColor(.black)
                                            Spacer()
                                        }
                                        .frame(width: 320)
                                        .offset(x: 0, y: -3)

                                        HStack{
                                            Image(systemName: "clock")
                                                .foregroundColor(.black)
                                            Text("\(calendar.numberOfDaysBetween(start: todayDate, end: viewmodel.group.endDate)) dias restantes")
                                                .foregroundColor(.black)
                                            Spacer()
                                        }
                                        .frame(width: 320)
                                        .offset(x: 0, y: 28)
                                    }
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
                            if viewmodel.posts.isEmpty {
                                Text("Não existem postagens no grupo.")
                            } else {
                                List(viewmodel.posts) { post in
                                    Button {
                                        self.isPostCardDisplay.toggle()
                                    } label: {
                                        CardPostView(title: post.title, memberName: post.owner!.name, createdDate: post.creationDate!)
                                    }.sheet(isPresented: $isPostCardDisplay){
                                        SheetPostView(viewmodel: self.viewmodel, selectedImage: self.$selectedImage, post: post)
                                    }
                                }
                            }
                        }

                        NavigationLink("", destination: GroupView(viewmodel: viewmodel), isActive: $performNavigation)
                            .hidden()
                        Spacer()
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
                    }.onAppear {
                        print(viewmodel.group.groupName)
                    }
                    .onChange(of: selectedImage) { selectedImage in
                        if selectedImage != nil {
                            sheet = .image
                        }
                    }
                    .sheet(item: $sheet) { sheet in
                        switch sheet {
                            case .image:
                            SheetCreatePostView(viewmodel: self.viewmodel, selectedImage: self.$selectedImage)
                            case .selection:
                            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}
