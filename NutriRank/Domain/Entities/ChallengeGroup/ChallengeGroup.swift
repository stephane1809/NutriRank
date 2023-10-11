//
//  ChallengeGroupModel.swift
//  NutriRankKit
//
//  Created by Paulo Henrique Gomes da Silva on 12/09/23.
//  Copyright © 2023 Merendeers. All rights reserved.
//

import Foundation
import CloudKit
import UIKit
import Nuvem

public struct ChallengeGroup: CKModel {
    public var record: CKRecord!

    public init() {}

    @CKField("groupName")
    public var groupName: String 

    @CKField("description")
    public var description: String

    @CKAssetField("groupImage")
    var groupImage: UIImage?

    @CKReferenceListField("members")
    var members: [Member]?

    @CKReferenceListField("posts")
    var posts: [Post]?
}
