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

    public var body: some View {

            HStack {
                VStack (alignment: .leading) {
                    Text(title)
                        .foregroundColor(.black)
                        .bold()
                    HStack {
                        Circle()
                            .foregroundColor(Color("FirstPlaceRanking"))
                            .frame(width: 27, height: 27)
                        Text(memberName)
                            .foregroundColor(.black)
                        Text(createdDate.description)
                            .foregroundColor(.black)
                    }
                }
                Spacer()
                Circle()
                    .foregroundColor(Color("FirstPlaceRanking"))
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
