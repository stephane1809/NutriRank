//
//  SheetPostView.swift
//  NutriRank
//
//  Created by Stephane Girão Linhares on 16/10/23.
//

import Foundation
import SwiftUI

public struct SheetPostView: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewmodel: FeedGroupViewModel
    @Binding var selectedImage: UIImage?
    @State var post: Post

    init(viewmodel: FeedGroupViewModel, selectedImage: Binding<UIImage?>, post: Post) {
        self.viewmodel = viewmodel
        self._selectedImage = selectedImage
        self._post = State<Post>(initialValue: post)
    }

    public var body: some View {
        NavigationStack {
            ZStack (alignment: .top) {
                Color(.defaultBackground)
                    .ignoresSafeArea()
                VStack (alignment: .leading, spacing: 20) {
    //                HStack (spacing: 48) {
    //                    Button {
    //                        dismiss()
    //                    } label: {
    //                        Text("Cancelar")
    //                    }
    //
    //                    Text("Postagem")
    //                        .fontWeight(.bold)
    //                        .font(.system(size: 20))
    //                }
    //                .padding(.vertical, 18)

                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Rectangle())
                            .scaledToFill()
                            .frame(width: 330, height: 150)
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
                        Circle()
                            .foregroundColor(Color("FirstPlaceRanking"))
                            .frame(width: 27, height: 27)
                        Text(post.owner!.name)
                            .foregroundColor(.black)
                        Text(post.creationDate!.description)
                            .foregroundColor(.black)
                    }

                }

            }.toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
            .navigationTitle("Postagem")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
