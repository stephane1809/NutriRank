//
//  AddMemberToGroupUseCase.swift
//  NutriRank
//
//  Created by Paulo Henrique Gomes da Silva on 11/10/23.
//

import Foundation

public struct AddMemberRequestedValues {
    public var member: Member
    public var group: ChallengeGroup

    init(_ member: Member, _ group: ChallengeGroup) {
        self.member = member
        self.group = group
    }
}

public protocol AddMemberToGroupUseCaseProtocol {
    func execute(requestValue: AddMemberRequestedValues) async -> Result<AddMemberRequestedValues, Error>
}

final public class DefaultAddMemberToGroupUseCase: AddMemberToGroupUseCaseProtocol {

    let repository: ChallengeMemberRepositoryProtocol

    init(repository: ChallengeMemberRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(requestValue: AddMemberRequestedValues) async -> Result<AddMemberRequestedValues, Error> {
        let result = await repository.addMemberToGroup(member: requestValue.member, group: requestValue.group)
        switch result {
        case .success(let values):
            return .success(values)
        case .failure(let error):
            return .failure(error)
        }
    }
}

