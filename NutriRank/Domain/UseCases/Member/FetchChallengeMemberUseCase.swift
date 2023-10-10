//
//  FetchChallengeMemberUseCase.swift
//  NutriRank
//
//  Created by Gabriel Santiago on 09/10/23.
//

import Foundation

public protocol FetchChallengeMemberUseCase {
    func execute(requestValue: String) async -> Result<Member, Error>
}

public class DefaultFetchChallengeMember: FetchChallengeMemberUseCase {

    var challengeMemberRepository: ChallengeMemberRepositoryProtocol

    init(challengeMemberRepository: ChallengeMemberRepositoryProtocol) {
        self.challengeMemberRepository = challengeMemberRepository
    }

    public func execute(requestValue: String) async -> Result<Member, Error> {
        let result = await challengeMemberRepository.fetchChallengeMember(id: requestValue)
        switch result {
            case .success(let member):
                return .success(member)
            case .failure(let error):
                return .failure(error)
        }
    }

    
}
