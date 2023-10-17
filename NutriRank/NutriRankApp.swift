//
//  NutriRankApp.swift
//  NutriRank
//
//  Created by Paulo Henrique Gomes da Silva on 02/10/23.
//

import SwiftUI

@main
struct NutriRankApp: App {
    var body: some Scene {
        WindowGroup {
//            if UserDefaults.standard.bool(forKey: "isFirstTimeUsingApp") == false {
//                FirstTimeUsingAppFactory.make()
//            } else {
//                ChallengeGroupFactory.make()
//            }
            FeedPostView()
//            CardPostView()
        }
    }
}
