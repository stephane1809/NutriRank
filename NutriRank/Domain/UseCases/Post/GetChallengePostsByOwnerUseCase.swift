//
//  GetChallengePostsByOwnerUseCase.swift
//  NutriRankDomain
//
//  Created by Paulo Henrique Gomes da Silva on 20/09/23.
//  Copyright © 2023 com.merendeers. All rights reserved.
//

import Foundation

public protocol GetChallengePostsByOwnerUseCase {
    func execute(_ member: Member) async -> Result<[Post], Error>
}

public class DefaultGetChallengePostsByOwnerUseCase {
    let repository: ChallengePostRepositoryProtocol

    init(repository: ChallengePostRepositoryProtocol) {
        self.repository = repository
    }

    func execute(_ member: Member) async -> Result<[Post], Error> {
        let result = await repository.getOwnersPost(member)
        switch result {
        case .success(let posts):
            return .success(posts)
        case .failure(let error):
            return .failure(error)
        }
    }
}
