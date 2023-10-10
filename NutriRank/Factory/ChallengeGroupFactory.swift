//
//  ChallengeGroupFactory.swift
//  NutriRank
//
//  Created by Paulo Henrique Gomes da Silva on 19/09/23.
//  Copyright © 2023 Merendeers. All rights reserved.
//

import Foundation
import SwiftUI

struct ChallengeGroupFactory {
    static func make() -> some View {
        let data = NutriRankNuvemClient()
        let dataPost = NutriRankClientPosts()
        let repository = DefaultChallengeGroupRepository(data: data)
        let postRepository = DefaultChallengePostRepository(data: dataPost)
        let createUseCase = DefaultCreateChallengeGroupUseCase(challengeGroupRepository: repository)
        let fetchUseCase = DefaultFetchGroupsUseCase(challengeGroupRepository: repository)
        let deleteUseCase = DefaultDeleteChallengeGroupUseCase(challengeGroupRepository: repository)
        let postUseCase = DefaultCreateChallengePostUseCase(repository: postRepository)
        let viewmodel = FeedGroupViewModel(createUseCase: createUseCase, createPostUseCase: postUseCase, fetchUseCase: fetchUseCase, deleteUseCase: deleteUseCase)
//        return CreateGroupView(viewmodel: viewmodel)
        return CreateGroupView(viewmodel: viewmodel)
    }
}
