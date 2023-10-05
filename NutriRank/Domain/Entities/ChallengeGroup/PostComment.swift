//
//  Comment.swift
//  NutriRankKit
//
//  Created by Paulo Henrique Gomes da Silva on 12/09/23.
//  Copyright © 2023 Merendeers. All rights reserved.
//

import Foundation
import CloudKit
import Nuvem

public struct PostComment: CKModel {
    public var record: CKRecord!

    public init() {}

    @CKReferenceField("commenter")
    var commenter: Member?

    @CKField("comment")
    var comment: String

    @CKReferenceField("post")
    var post: Post?
}
