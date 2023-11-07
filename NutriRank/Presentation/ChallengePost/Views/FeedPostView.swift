//
//  FeedPostView.swift
//  NutriRank
//
//  Created by Stephane Girão Linhares on 09/10/23.
//

import Foundation
import SwiftUI
import PhotosUI

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
    @State private var postToShow: Post?
    @State private var arePostsLoading = true
    
    @State private var sheet: Sheet?

    public var body: some View {
        GeometryReader { metrics in
            ZStack {

                if arePostsLoading {
                    ProgressView()
                        .controlSize(.large)
                        .offset(y:100)
                        .zIndex(1.0)
                }

                Color(.defaultBackground)
                    .ignoresSafeArea()
                VStack (alignment: .center, spacing: 20) {

                    Button {
                        self.performNavigation.toggle()
                    } label: {
                        ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 350, height: 137)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 7)
//                                                    .stroke(Color.black, lineWidth: 1.5)
                                        )
                                        .foregroundColor(Color("FeedGroupHeaderColor"))
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
                            .frame(width: 327, height: 35)
                            .foregroundColor(.white)
                    }
                    .background(Color("FirstPlaceRanking"))
                    .cornerRadius(10)
                    .buttonStyle(.bordered)

                    VStack {
                        Text("Postagens")
                        if viewmodel.posts.isEmpty {
                            if arePostsLoading == false {
                                Text("Não existem postagens no grupo.")
                                    .offset(y:230)
                            }
                        } else {
                            ScrollView {
                                ForEach(viewmodel.sortedPostForDate) { post in
                                    CardPostView(post: post)
                                        .onTapGesture {
                                            self.postToShow = post
                                        }
                                }
                            }.sheet(item: $postToShow) { post in
                                SheetPostView(post: post)
                            }
                        }
                    }
                    Spacer()
                }
                .confirmationDialog("Escolha uma opção", isPresented: $isImagePickerDisplay) {
                    Button("Câmera") {
                        self.sourceType = .camera
                        self.sheet = .selection
                    }
                    Button("Galeria") {
                        if PHPhotoLibrary.authorizationStatus(for: .readWrite) == .authorized {
                            self.sourceType = .photoLibrary
                            self.sheet = .selection
                        } else {
                            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                                if status == .authorized {
                                    self.sourceType = .photoLibrary
                                    self.sheet = .selection
                                }
                            }
                        }
                    }
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
                .task {
                    if self.viewmodel.group.record != nil {
                        await viewmodel.fetchPosts()
                        self.arePostsLoading = false
                    }
                }
            }.navigationDestination(isPresented: $performNavigation, destination: { GroupView(viewmodel: viewmodel) })
            .navigationBarBackButtonHidden(true)
        }
    }
}
