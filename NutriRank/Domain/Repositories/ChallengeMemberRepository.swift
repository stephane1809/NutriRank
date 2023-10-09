//
//  ChallengeMemberRepository.swift
//  NutriRank
//
//  Created by Gabriel Santiago on 09/10/23.
//

import Foundation

public protocol ChallengeMemberRepositoryProtocol {
    func createChallengeMember(member: Member) async -> Result<Member, Error>
}

public class DefaultChallengeMemberRepository: ChallengeMemberRepositoryProtocol {

    let data: ChallengeMemberRepositoryProtocol

    init(data: ChallengeMemberRepositoryProtocol) {
        self.data = data
    }

    public func createChallengeMember(member: Member) async -> Result<Member, Error> {
        let result = await data.createChallengeMember(member: member)
        switch result {
        case .success(let member):
            return .success(member)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    
}
