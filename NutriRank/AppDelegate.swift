//
//  AppDelegate.swift
//  NutriRank
//
//  Created by Gabriel Santiago on 08/11/23.
//

import Foundation
import SwiftUI
import Mixpanel

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Mixpanel.mainInstance().track(event: "App Started", properties: MixpanelProductionIndicator.Production.retrieveDict())
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        Mixpanel.mainInstance().track(event: "App closed", properties: MixpanelProductionIndicator.Production.retrieveDict())
    }
}
