//
//  FetchGroupByMember.swift
//  NutriRank
//
//  Created by Paulo Henrique Gomes da Silva on 18/10/23.
//

import Foundation

public protocol FetchGroupByMemberUseCaseProtocol {
    func execute(requestValue: Member) async -> Result<ChallengeGroup, Error>
}

public final class DefaultFetchGroupByMemberUseCase: FetchGroupByMemberUseCaseProtocol {

    let repository: ChallengeGroupRepositoryProtocol

    public init(repository: ChallengeGroupRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(requestValue: Member) async -> Result<ChallengeGroup, Error> {
        let result = await repository.fetchGroupByMember(member: requestValue)
        switch result {
        case .success(let group):
            return .success(group)
        case .failure(let error):
            return .failure(error)
        }
    }
}
