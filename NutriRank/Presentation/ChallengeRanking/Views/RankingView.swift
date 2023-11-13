//
//  RankingView.swift
//  NutriRank
//
//  Created by Gabriel Santiago on 05/10/23.
//

import SwiftUI
import Mixpanel

struct RankingView: View {

    var viewmodel: FeedGroupViewModel

    var body: some View {
        VStack{
            RankingCardComponent(challengeSpan: viewmodel.group.duration, challengeDescription: viewmodel.group.description, groupTitle: viewmodel.group.groupName)
                .padding(.top, 20)
                .padding(.bottom, 18)
            ScrollView{
                ForEach(Array(viewmodel.sortedRankingGroup.enumerated()), id: \.offset) { (index, item) in
                    RankingCellComponent(rankingPosition: index, profileAvatar: item.avatar!, userName: item.name, mealCount: item.score)
                        .padding(.bottom, -2)
                }
            }
        }
        .background(Color(.defaultBackground))
        .onAppear{
            Mixpanel.mainInstance().track(event: "Ranking View", properties: MixpanelProductionIndicator.Production.retrieveDict())

        }
    }
}
