//
//  DeleteChallengeGroupUseCase.swift
//  NutriRankDomain
//
//  Created by Gabriel Santiago on 21/09/23.
//  Copyright © 2023 com.merendeers. All rights reserved.
//

import Foundation

public protocol  DeleteChallengeGroupUseCase {
    func execute(group: ChallengeGroup) async -> Result<Bool, Error>
}

public class DefaultDeleteChallengeGroupUseCase: DeleteChallengeGroupUseCase {

    let challengeGroupRepository: ChallengeGroupRepositoryProtocol

    public init(challengeGroupRepository: ChallengeGroupRepositoryProtocol) {
        self.challengeGroupRepository = challengeGroupRepository
    }

    public func execute(group: ChallengeGroup) async -> Result<Bool, Error> {
        print("delete chegou no usecase")
        let result = await challengeGroupRepository.deleteChallengeRepository(group: group)
        switch result {
            case .success(let bool):
                return .success(bool)
            case .failure(let error):
                return .failure(error)
        }
    }

    
}
