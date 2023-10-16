//
//  FirstTimeUsingAppFactory.swift
//  NutriRank
//
//  Created by Gabriel Santiago on 10/10/23.
//

import Foundation
import SwiftUI

struct FirstTimeUsingAppFactory {
    static func make() -> some View {
        let data = NutriRankNuvemClient()
        let dataPost = NutriRankClientPosts()
        let memberData = NutriRankMemberClient()

        let repository = DefaultChallengeGroupRepository(data: data)
        let postRepository = DefaultChallengePostRepository(data: dataPost)
        let createUseCase = DefaultCreateChallengeGroupUseCase(challengeGroupRepository: repository)
        let memberRepository = DefaultChallengeMemberRepository(data: memberData)


        let fetchUseCase = DefaultFetchGroupsUseCase(challengeGroupRepository: repository)
        let deleteUseCase = DefaultDeleteChallengeGroupUseCase(challengeGroupRepository: repository)
        let postUseCase = DefaultCreateChallengePostUseCase(repository: postRepository)
        let createMemberUseCase = DefaultChallengeCreateMemberUseCase(challengeMemberRepository: memberRepository)
        let updateMemberUseCase = DefaultUpdateChallengeMemberUseCase(challengeMemberRepository: memberRepository)
        let fetchMemberUseCase = DefaultFetchChallengeMember(challengeMemberRepository: memberRepository)
        let addMemberUseCase = DefaultAddMemberToGroupUseCase(repository: memberRepository)
        let fetchGroupByIDUseCase = DefaultFetchGroupByIdUsecase(repository: repository)

        let viewmodel = FeedGroupViewModel(createUseCase: createUseCase, createPostUseCase: postUseCase, fetchUseCase: fetchUseCase, deleteUseCase: deleteUseCase, createMemberUseCase: createMemberUseCase, updateMemberUseCase: updateMemberUseCase, fetchMemberUseCase: fetchMemberUseCase, fetchGroupByIDUseCase: fetchGroupByIDUseCase, addMemberUseCase: addMemberUseCase)

        return OnboardingView(viewModel: viewmodel)
    }
}

