//
//  ChallengeMember.swift
//  NutriRankKit
//
//  Created by Paulo Henrique Gomes da Silva on 12/09/23.
//  Copyright © 2023 Merendeers. All rights reserved.
//

import Foundation
import Nuvem
import CloudKit
import UIKit

public struct Member: CKModel {
    public var record: CKRecord!

    public init() {}

    @CKField("name")
    var name: String

    @CKField("score")
    var score: Int

    @CKAssetField("avatar")
    var avatar: UIImage?

}
