//
//  Post.swift
//  NutriRankKit
//
//  Created by Paulo Henrique Gomes da Silva on 12/09/23.
//  Copyright © 2023 Merendeers. All rights reserved.
//

import Foundation
import CloudKit
import UIKit
import Nuvem

public struct Post: CKModel {
    public var record: CKRecord!

    public init() {}

    @CKField("title")
    public var title: String

    @CKField("description")
    public var description: String

    @CKField("upVote")
    public var upVote: Int

    @CKField("downVote")
    public var downVote: Int

    @CKAssetField("postImage")
    public var postImage: UIImage?

    @CKReferenceField("owner")
    public var owner: Member?

    @CKReferenceListField("comments")
    var comments: [PostComment]?

    @CKReferenceField("challengeGroup")
    var challengeGroup: ChallengeGroup?
}
