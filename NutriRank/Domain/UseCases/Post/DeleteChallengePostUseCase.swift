//
//  DeleteChallengePostUseCase.swift
//  NutriRankDomain
//
//  Created by Paulo Henrique Gomes da Silva on 20/09/23.
//  Copyright © 2023 com.merendeers. All rights reserved.
//

import Foundation

public protocol DeleteChallengePostUseCaseProtocol {
    func execute(_ post: Post) async -> Result<Bool, Error>
}

public class DefaultDeleteChallengePostUseCase: DeleteChallengePostUseCaseProtocol {
    let repository: ChallengePostRepositoryProtocol

    init(repository: ChallengePostRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(_ post: Post) async -> Result<Bool, Error> {
        let result = await repository.deleteChallengePost(post)
        switch result {
        case .success(let bool):
            return .success(bool)
        case .failure(let error):
            return .failure(error)
        }
    }
}
