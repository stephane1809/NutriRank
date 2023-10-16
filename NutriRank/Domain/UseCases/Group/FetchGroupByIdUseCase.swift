//
//  FetchGroupById.swift
//  NutriRank
//
//  Created by Paulo Henrique Gomes da Silva on 11/10/23.
//

import Foundation

public protocol FetchGroupByIdUseCaseProtocol {
    func execute(requestValue: String) async -> Result<ChallengeGroup, Error>
}

public class DefaultFetchGroupByIdUsecase: FetchGroupByIdUseCaseProtocol {
    
    let repository: ChallengeGroupRepositoryProtocol

    init(repository: ChallengeGroupRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(requestValue: String) async -> Result<ChallengeGroup, Error> {
        let result = await repository.fetchGroupByID(id: requestValue)
        switch result {
        case .success(let group):
            return .success(group)
        case .failure(let error):
            return .failure(error)
        }
    }
}
