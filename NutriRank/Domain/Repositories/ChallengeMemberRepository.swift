//
//  ChallengeMemberRepository.swift
//  NutriRank
//
//  Created by Gabriel Santiago on 09/10/23.
//

import Foundation

public protocol ChallengeMemberRepositoryProtocol {
    func createChallengeMember(member: Member) async -> Result<Member, Error>
    func updateChallengeMember(member: Member) async -> Result<Member, Error>
    func fetchChallengeMember(id: String) async -> Result<Member, Error>
    func addMemberToGroup(member: Member, group: ChallengeGroup) async -> Result<AddMemberRequestedValues, Error>
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

    public func updateChallengeMember(member: Member) async -> Result<Member, Error> {
        var memberToSave = member
        memberToSave.score += 1
        let result = await data.updateChallengeMember(member: memberToSave)
        switch result {
        case .success(let member):
            return .success(member)
        case .failure(let error):
            return .failure(error)
        }
    }

    public func fetchChallengeMember(id: String) async -> Result<Member, Error> {
        let result = await data.fetchChallengeMember(id: id)
        switch result {
        case .success(let member):
            return .success(member)
        case .failure(let error):
            return .failure(error)
        }
    }

    public func addMemberToGroup(member: Member, group: ChallengeGroup) async -> Result<AddMemberRequestedValues, Error> {
        var groupToSave = group
        var memberToSave = member
        guard var members = group.members else {
            return .failure(SaveErrors.guardError)
        }
        members.append(memberToSave)
        groupToSave.members = members
        memberToSave.group = groupToSave
        let result = await data.addMemberToGroup(member: memberToSave, group: groupToSave)
        switch result {
        case .success(let values):
            return .success(values)
        case .failure(let error):
            return .failure(error)
        }
    }
}

enum SaveErrors: Error {
    case guardError
}

extension SaveErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .guardError:
            return "Error when trying to guard let the variable. A nil value was found."
        }
    }
}



