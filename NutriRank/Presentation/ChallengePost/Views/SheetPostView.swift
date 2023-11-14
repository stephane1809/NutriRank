//
//  SheetPostView.swift
//  NutriRank
//
//  Created by Stephane Girão Linhares on 16/10/23.
//

import Foundation
import SwiftUI
import Mixpanel

public struct SheetPostView: View {

    @StateObject var viewmodel: FeedGroupViewModel
    @Environment(\.dismiss) var dismiss
    @State var post: Post
    @Binding var deletedPost: Bool
    @State var deletingPost: Bool = false
    @State var alertDeletPost: Bool = false

    public var body: some View {
        NavigationStack {
            ZStack (alignment: .top) {
                Color(.defaultBackground)
                    .ignoresSafeArea()
                VStack (alignment: .leading, spacing: 20) {
                    if post.postImage != nil {
                        Image(uiImage: post.postImage!)
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

                    Text(post.title)
                        .font(.title2)
                        .bold()

                    Text(post.description)
                        .lineLimit(1...10)

                    HStack {
                        Image(uiImage: post.owner!.avatar!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .scaledToFill()
                            .frame(width: 27, height: 27)
                        Text(post.owner!.name)

                            .foregroundColor(.primary)
                        Text(post.creationDate!.formatted())
                            .foregroundColor(.primary)
                    }
                }

            }.toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .destructiveAction) {
                    Button {
                        Task {
                            alertDeletPost.toggle()
                        }
                    } label: {
                        if deletingPost {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Apagar")
                        }
                    }
                }
            }
            .alert("Você tem certeza que deseja apagar postagem?", isPresented: $alertDeletPost) {
                Button("Cancelar", role: .cancel) {}
                Button("Apagar", role: .destructive) {
                    Task {
                        self.deletingPost = true
                        let result = await viewmodel.deletePost(post: self.post)
                        if result {
                            self.deletingPost = false
                            dismiss()
                            self.deletedPost = true
                        }

                    }
                }
            }
            .navigationTitle("Postagem")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                Mixpanel.mainInstance().track(event: "Post View", properties: MixpanelProductionIndicator.Production.retrieveDict())
            }
        }
    }
}
