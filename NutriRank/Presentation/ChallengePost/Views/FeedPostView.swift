//
//  FeedPostView.swift
//  NutriRank
//
//  Created by Stephane Girão Linhares on 09/10/23.
//

import Foundation
import SwiftUI
import PhotosUI
import Mixpanel

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

    @Environment(\.dismiss) var dismiss

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
    @State private var performRankingNavigation = false
    @State var leavedGroup = false
    @State var deletedPost = false

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
                        Mixpanel.mainInstance().track(event: "Taped Group Card", properties: MixpanelProductionIndicator.Production.retrieveDict())
                    } label: {
                        ZStack{

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
                                    .padding(.bottom, 30)

                                    HStack{
                                        Image(systemName: "clock")
                                            .foregroundColor(.black)
                                        Text("\(calendar.numberOfDaysBetween(start: todayDate, end: viewmodel.group.endDate)) dias restantes")
                                            .foregroundColor(.black)
                                        Spacer()
                                        Text("Ver grupo >")
                                            .foregroundStyle(Color("actionButton"))
                                            .underline()
                                    }
                                    .frame(width: 320)
                                    .padding(.top, 30)
                                }
                        .frame(width: 365, height: 98)
                        .background(Color("FeedGroupHeaderColor"))
                        .cornerRadius(10)
                        .shadow(radius: 1, x: 0, y: 1)
                    }
                    .padding(.top, 13)

                    Button {
                        self.isImagePickerDisplay.toggle()
                        Mixpanel.mainInstance().track(event: "Tapped new post button", properties: MixpanelProductionIndicator.Production.retrieveDict())
                        //                            sheet = .selection
                    } label: {
                        Text("+ Nova Postagem")
                            .font(.headline)
                            .frame(width: 327, height: 35)
                            .foregroundColor(.white)
                    }
                    .background(Color("actionButton"))
                    .cornerRadius(10)
                    .buttonStyle(.bordered)

                    VStack {
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
                                SheetPostView(viewmodel: viewmodel, post: post, deletedPost: $deletedPost)
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
                .onChange(of: deletedPost) { deletedPost in
                    if deletedPost {
                        Task {
                            self.arePostsLoading = true
                            await viewmodel.fetchPosts()
                            self.arePostsLoading = false
                            self.deletedPost = false
                        }
                    }
                }
                .onChange(of: leavedGroup) { leavedGroup in
                    if leavedGroup {
                        dismiss()
                        self.leavedGroup = false
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
            }.navigationDestination(isPresented: $performNavigation, destination: { GroupView(viewmodel: viewmodel, self.$leavedGroup) })
                .navigationBarBackButtonHidden(true)
            .onAppear{
                Mixpanel.mainInstance().track(event: "Group Feed View", properties: MixpanelProductionIndicator.Production.retrieveDict())
            }
            .navigationDestination(isPresented: $performRankingNavigation, destination: {RankingView(viewmodel: viewmodel)})
            .navigationTitle(viewmodel.group.groupName)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {

                    }) {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .foregroundStyle(Color("actionButton"))
                            .padding(.leading, 7)

                    }
                }

                ToolbarItem(placement: .topBarTrailing) {

                    Button(action: {
                        self.performRankingNavigation = true
                        Mixpanel.mainInstance().track(event: "Tapped Ranking Button", properties: MixpanelProductionIndicator.Production.retrieveDict())

                    }) {
                        Image(systemName: "trophy.fill")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .foregroundStyle(Color("actionButton"))
                            .padding(.trailing, 7)
                    }
                }
            }
        }
    }
}
