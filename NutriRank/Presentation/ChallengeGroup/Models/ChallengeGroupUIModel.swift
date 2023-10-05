//
//  ChallengeGroupUIModel.swift
//  NutriRankUI
//
//  Created by Paulo Henrique Gomes da Silva on 13/09/23.
//  Copyright © 2023 Merendeers. All rights reserved.
//

import Foundation

public struct ChallengeGroupUIModel: Identifiable {
    public let id: UUID = UUID()
    var name: String
    var description: String

    public init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}
