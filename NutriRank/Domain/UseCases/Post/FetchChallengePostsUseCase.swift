//
//  FetchChallengePostsUseCase.swift
//  NutriRankDomain
//
//  Created by Paulo Henrique Gomes da Silva on 20/09/23.
//  Copyright © 2023 com.merendeers. All rights reserved.
//

import Foundation

public protocol FetchChallengePostsUseCaseProtocol {
    func execute() async -> Result<[Post], Error>
}

public class DefaultFetchChallengePostsUseCase: FetchChallengePostsUseCaseProtocol {
    let repository: ChallengePostRepositoryProtocol

    init(repository: ChallengePostRepositoryProtocol) {
        self.repository = repository
    }

    public func execute() async -> Result<[Post], Error> {
        let result = await repository.fetchAllPosts()
        switch result {
        case .success(let posts):
            return .success(posts)
        case .failure(let error):
            return .failure(error)
        }
    }
}
