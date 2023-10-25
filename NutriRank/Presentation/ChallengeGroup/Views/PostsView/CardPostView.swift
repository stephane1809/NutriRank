//
//  CardPostView.swift
//  NutriRank
//
//  Created by Stephane Girão Linhares on 09/10/23.
//

import Foundation
import SwiftUI

public struct CardPostView: View {

    @State var title: String
    @State var memberName: String
    @State var createdDate: Date
    @State var postImage: UIImage
    @State var userAvatar: UIImage?

    public var body: some View {

            HStack {
                VStack (alignment: .leading) {
                    Text(title)
                        .foregroundColor(.black)
                        .bold()
                    HStack {
                        Image(uiImage: userAvatar!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .scaledToFill()
                            .frame(width: 27, height: 27)

                        Text(memberName)
                            .foregroundColor(.black)
                        Text(createdDate.description)
                            .foregroundColor(.black)
                    }
                }
                Spacer()
                Image(uiImage: postImage)
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
struct CardPostView_Previews: PreviewProvider {
    static var previews: some View {
        CardPostView(title: "Grupo massa", memberName: "comida", createdDate: Date(), postImage: UIImage(), userAvatar: UIImage())
    }
}
