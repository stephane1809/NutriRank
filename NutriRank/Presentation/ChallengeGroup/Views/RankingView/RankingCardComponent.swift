//
//  RankingCardComponent.swift
//  NutriRank
//
//  Created by Gabriel Santiago on 05/10/23.
//

import SwiftUI

struct RankingCardComponent: View {
    var challengeSpan: Int
    var challengeDescription: String
    var groupTitle: String

    init(challengeSpan: Int, challengeDescription: String, groupTitle: String) {
        self.challengeSpan = challengeSpan
        self.challengeDescription = challengeDescription
        self.groupTitle = groupTitle
    }

    var body: some View {

        ZStack{
            Rectangle()
                .frame(width: 370, height: 170)
                .cornerRadius(7)
                .foregroundColor(Color("DefaultCardColor"))
                .shadow(radius: 1, y:3)

            HStack{
                Text(groupTitle)
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .lineLimit(1)
                Spacer()
            }
            .frame(width: 310)
            .offset(x: -16, y:-55)

            HStack {
                Text(challengeDescription)
                Spacer()
            }
            .offset(x:0,y:4)
            .frame(width: 350, height:90)
            .lineLimit(3)

            Text("Duração: \(challengeSpan) dias")
                .offset(x:-107, y:64)

        }
    }
}

struct GroupHeaderComponent_Previews: PreviewProvider {
    static var previews: some View {
        RankingCardComponent(challengeSpan: 28, challengeDescription: "Lorem ipsum ejndiu3", groupTitle: "Abcde")
    }
}
