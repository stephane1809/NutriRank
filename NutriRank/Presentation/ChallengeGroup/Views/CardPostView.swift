//
//  CardPostView.swift
//  NutriRank
//
//  Created by Stephane Girão Linhares on 09/10/23.
//

import Foundation
import SwiftUI

public struct CardPostView: View {

    public init() {}

    public var body: some View {

            HStack {
                VStack (alignment: .leading) {
                    Text("Título do post")
                        .bold()
                    HStack {
                        Circle()
                            .foregroundColor(Color("FirstPlaceRanking"))
                            .frame(width: 27, height: 27)
                        Text("Nome do usuário")
                        Text("- 09/10")
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
            .background(.white)
            .cornerRadius(10)
            .shadow(radius: 1, x: 0, y: 1)


    }

}
