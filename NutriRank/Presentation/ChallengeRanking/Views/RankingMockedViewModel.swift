//
//  RankingMockedViewModel.swift
//  NutriRank
//
//  Created by Gabriel Santiago on 05/10/23.
//

import Foundation

class MockedViewmodel {

    struct mockedUser: Hashable{
        var name: String
        var profileAvatar: String
        var mealCount: Int
        var totalUpvotes: Int
    }

    var mockedUsersArray: [mockedUser] = [
        mockedUser(name: "paulinho", profileAvatar: "UserMockImage", mealCount: 30, totalUpvotes: 30),
        mockedUser(name: "marilda", profileAvatar: "UserMockImage", mealCount: 26, totalUpvotes: 26),
        mockedUser(name: "papito pakulu", profileAvatar: "UserMockImage", mealCount: 13, totalUpvotes: 13),
        mockedUser(name: "ratatouille", profileAvatar: "UserMockImage", mealCount:13, totalUpvotes: 13),
        mockedUser(name: "rodrigo faro", profileAvatar: "UserMockImage", mealCount: 51, totalUpvotes: 51),
        mockedUser(name: "adriane", profileAvatar: "UserMockImage", mealCount: 9, totalUpvotes: 9)
    ]


    lazy var sortedArray = mockedUsersArray.sorted {$0.mealCount > $1.mealCount}


}
