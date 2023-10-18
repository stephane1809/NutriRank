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
                        self.cellColor = "FirstPlaceRanking"
                    } else if rankingPosition == 1 {
                        self.cellColor = "SecondPlaceRanking"
                    } else if rankingPosition == 2 {
                        self.cellColor = "ThirdPlaceRanking"
                    } else {
                        self.cellColor = "DefaultRankingCellColor"
                    }

                }

            HStack {
                Text("\(rankingPosition + 1)")
                    .fontWeight(.semibold)
                    .font(.system(size: 18))
                    .padding(.trailing, 7)
                    .padding(.leading, 10)
                Image(uiImage: profileAvatar)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .padding(.trailing, 26)
                VStack(alignment: .leading) {
                    Text(userName)
                        .fontWeight(.semibold)
                        .font(.system(size: 18))

                    Text("\(mealCount) refeiçoes")
                }
                Spacer()
            }
            .padding(.leading)
            .padding(.trailing)
        }
    }
}

//struct RankingCellComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        RankingCellComponent(rankingPosition: 1, profileAvatar: "UserMockImage", userName: "Drake", mealCount: 26)
//    }
//}
