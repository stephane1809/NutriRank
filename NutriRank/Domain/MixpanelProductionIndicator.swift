//
//  MixpanelProductionIndicator.swift
//  NutriRank
//
//  Created by Gabriel Santiago on 08/11/23.
//

import Foundation



enum MixpanelProductionIndicator {
    case Production
    case NotProduction

    func retrieveDict() -> [String : Bool] {
        switch self{
            case .Production:
                return ["Production": true]
            case .NotProduction:
                return ["Production": false]
        }
    }
}
