//
//  RankingView.swift
//  NutriRank
//
//  Created by Gabriel Santiago on 05/10/23.
//

import SwiftUI

struct RankingView: View {

    var viewmodel = MockedViewmodel()

    var body: some View {
        VStack{
            RankingCardComponent(challengeSpan: 29, challengeDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis accumsan vulputate feugiat. Nam a sollicitudin neque, et bibendum nisl. Integer blandit semper tellus, suscipit lobortis metus. Nunc sit amet justo metus. Cras in egestas libero. Vestibulum in nunc quis ligula placerat laoreet in nec risus. Suspendisse eu purus lectus", groupTitle: "Aracnodactilia")
                .padding(.top, 20)
                .padding(.bottom, 18)
            ScrollView{
                ForEach(Array(self.viewmodel.sortedArray.enumerated()), id: \.element) {(index, item) in

                    RankingCellComponent(rankingPosition: index, profileAvatar: item.profileAvatar, userName: item.name, mealCount: item.mealCount)
                        .padding(.bottom, -2)
                }
            }
        }
        .background(Color("DefaultBackgroundColor"))
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
    }
}
