//
//  CardPostView.swift
//  NutriRank
//
//  Created by Stephane Girão Linhares on 09/10/23.
//

import Foundation
import SwiftUI

public struct CardPostView: View {

    @State var post: Post

    public var body: some View {

            HStack {
                VStack (alignment: .leading) {
                    Text(post.title)
                        .foregroundColor(.black)
                        .bold()
                    HStack {
                        Image(uiImage: (post.owner?.avatar)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .scaledToFill()
                            .frame(width: 27, height: 27)

                        Text(post.owner!.name)
                            .foregroundColor(.black)
                        Text((post.creationDate?.formatted())!)
                            .foregroundColor(.black)
                    }
                }
                Spacer()
                Image(uiImage: post.postImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .scaledToFill()
                    .frame(width: 60, height: 60)

            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .frame(width: 365, height: 85)
            .background(Color("DefaultCardColor"))
            .cornerRadius(10)
            .shadow(radius: 1, x: 0, y: 1)


    }

}
