//
//  RankingCellComponent.swift
//  NutriRank
//
//  Created by Gabriel Santiago on 05/10/23.
//

import SwiftUI

struct RankingCellComponent: View {

    var rankingPosition: Int
    var profileAvatar: UIImage
    var userName: String
    var mealCount: Int

    @State var cellColor: String = "DefaultRankingCellColor"
    @State var indexColor: Color = Color(uiColor: .label)

    init(rankingPosition: Int, profileAvatar: UIImage, userName: String, mealCount: Int) {
        self.rankingPosition = rankingPosition
        self.profileAvatar = profileAvatar
        self.userName = userName
        self.mealCount = mealCount
    }

    var body: some View {

        ZStack{
            Rectangle()
                .frame(width: 370, height: 62)
                .foregroundColor(Color(cellColor))
                .cornerRadius(7)
                .onAppear {
                    if rankingPosition == 0 {
                        self.cellColor = "placeRanking1"
                        self.indexColor = Color(.black)
                    } else if rankingPosition == 1 {
                        self.cellColor = "placeRanking2"
                        self.indexColor = Color(.black)
                    } else if rankingPosition == 2 {
                        self.cellColor = "placeRanking3"
                        self.indexColor = Color(.black)
                    } else {
                        self.cellColor = "DefaultRankingCellColor"
                        self.indexColor = Color(uiColor: .label)
                    }

                }

            HStack {
                Text("\(rankingPosition + 1)")
                    .fontWeight(.semibold)
                    .font(.system(size: 18))
                    .padding(.trailing, 7)
                    .padding(.leading, 10)
                    .foregroundColor(indexColor)
                Image(uiImage: profileAvatar)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .padding(.trailing, 26)
                VStack(alignment: .leading) {
                    Text(userName)
                        .fontWeight(.semibold)
                        .font(.system(size: 18))
                        .foregroundColor(indexColor)
                    Text("\(mealCount) refeições")
                        .foregroundColor(indexColor)
                }
                Spacer()
            }
            .padding(.leading)
            .padding(.trailing)
        }
    }
}
