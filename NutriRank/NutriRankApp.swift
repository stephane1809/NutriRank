//
//  NutriRankApp.swift
//  NutriRank
//
//  Created by Paulo Henrique Gomes da Silva on 02/10/23.
//

import SwiftUI
import Mixpanel

@main
struct NutriRankApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {

        WindowGroup {
            NavigationStack {
                if UserDefaults.standard.bool(forKey: "isFirstTimeUsingApp") == false {
                    FirstTimeUsingAppFactory.make()
                } else {
                    ChallengeGroupFactory.make()
                }
            }
        }
    }

    init() {
        Mixpanel.initialize(
            token: "5dc6bcad6e4d2114ee9f8aa59235e242",
            trackAutomaticEvents: true)
    }
}
