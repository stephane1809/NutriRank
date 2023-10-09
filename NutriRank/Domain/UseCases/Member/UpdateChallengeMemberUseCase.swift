//
//  UpdateMemberUseCase.swift
//  NutriRank
//
//  Created by Gabriel Santiago on 09/10/23.
//

import Foundation


public protocol UpdateChallengeMemberUseCase {
    func execute(requestValue: Member) async -> Result<Member, Error>
}

public class DefaultUpdateChallengeMember: UpdateChallengeMemberUseCase {

    var challengeMemberRepository: ChallengeMemberRepositoryProtocol

    init(challengeMemberRepository: ChallengeMemberRepositoryProtocol) {
        self.challengeMemberRepository = challengeMemberRepository
    }

    public func execute(requestValue: Member) async -> Result<Member, Error> {
        let result  = await challengeMemberRepository.updateChallengeMember(member: requestValue)
        switch result {
            case .success(let member):
                return .success(member)
            case .failure(let error):
                return .failure(error)
        }
    }
    
}
