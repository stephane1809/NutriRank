//
//  CreateChallengeMemberUseCase.swift
//  NutriRank
//
//  Created by Gabriel Santiago on 09/10/23.
//

import Foundation


public protocol CreateChallengeMemberUseCase {
    func execute(requestValue: Member) async -> Result<Member, Error>
}

public class DefaultChallengeCreateMemberUseCase: CreateChallengeMemberUseCase {


    var challengeMemberRepository: ChallengeMemberRepositoryProtocol

    init(challengeMemberRepository: ChallengeMemberRepositoryProtocol) {
        self.challengeMemberRepository = challengeMemberRepository
    }

    public func execute(requestValue: Member) async -> Result<Member, Error> {
        let result  = await challengeMemberRepository.createChallengeMember(member: requestValue)
        switch result {
            case .success(let member):
                return .success(member)
            case .failure(let error):
                return .failure(error)
        }
    }
}
