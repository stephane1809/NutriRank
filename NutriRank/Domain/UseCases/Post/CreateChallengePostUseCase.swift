//
//  ChallengePostUseCase.swift
//  NutriRankDomain
//
//  Created by Paulo Henrique Gomes da Silva on 20/09/23.
//  Copyright © 2023 com.merendeers. All rights reserved.
//

import Foundation

public protocol CreateChallengePostUseCase {
    func execute(_ requestValue: Post) async -> Result<Post, Error>
}

public class DefaultCreateChallengePostUseCase: CreateChallengePostUseCase {
    let repository: ChallengePostRepositoryProtocol

    public init(repository: ChallengePostRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(_ requestValue: Post) async -> Result<Post, Error> {
        let result = await repository.createChallengePost(requestValue)
        switch result {
        case .success(let post):
            return .success(post)
        case .failure(let error):
            return .failure(error)
        }
    }
}
