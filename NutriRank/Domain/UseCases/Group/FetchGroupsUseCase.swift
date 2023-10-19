//
//  FetchGroupsUseCase.swift
//  NutriRankDomain
//
//  Created by Gabriel Santiago on 20/09/23.
//  Copyright © 2023 com.merendeers. All rights reserved.
//

import Foundation


public protocol FetchChallengeGroupsUseCase{
    func execute() async -> Result<[ChallengeGroup], Error>
}

public class DefaultFetchGroupsUseCase: FetchChallengeGroupsUseCase {

    let challengeGroupRepository: ChallengeGroupRepositoryProtocol

    public init(challengeGroupRepository: ChallengeGroupRepositoryProtocol) {
        self.challengeGroupRepository = challengeGroupRepository
    }
    
    public func execute() async -> Result<[ChallengeGroup], Error> {
        let result = await challengeGroupRepository.fetchChallengeGroups()
        switch result{
            case .success(let groupList):
                return .success(groupList)
            case . failure(let error):
                return.failure(error)
        }
    }

    
}
