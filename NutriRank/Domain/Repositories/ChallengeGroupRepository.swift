//
//  ChallengeGroupRepository.swift
//  NutriRankKit
//
//  Created by Paulo Henrique Gomes da Silva on 13/09/23.
//  Copyright © 2023 Merendeers. All rights reserved.
//

import Foundation

public protocol ChallengeGroupRepositoryProtocol {
    func fetchChallengeGroups() async -> Result<[ChallengeGroup], Error>
    func createChallengeGroup(group: ChallengeGroup) async -> Result<ChallengeGroup, Error>
    func leaveGroupRepository(group: ChallengeGroup, member: Member) async -> Result<Bool, Error>
    func fetchGroupByMember(member: Member) async -> Result<ChallengeGroup, Error>
    func fetchGroupByID(id: String) async -> Result<ChallengeGroup, Error>
}

public class DefaultChallengeGroupRepository: ChallengeGroupRepositoryProtocol {

    let data: ChallengeGroupRepositoryProtocol

    public init(data: ChallengeGroupRepositoryProtocol) {
        self.data = data
    }

    public func fetchChallengeGroups() async -> Result<[ChallengeGroup], Error> {
        let result = await data.fetchChallengeGroups()
        switch result {
            case .success(let groupList):
                return .success(groupList) 
            case .failure(let error):
                return .failure(error)
        }
    }


    public func createChallengeGroup(group: ChallengeGroup) async -> Result<ChallengeGroup, Error> {
        print("chegou no repository")
            let result = await data.createChallengeGroup(group: group)
            switch result {
            case .success(let group):
                return .success(group)
            case .failure(let error):
                return .failure(error)
            }
    }

    public func leaveGroupRepository(group: ChallengeGroup, member: Member) async -> Result<Bool, Error> {
        var groupToSave = group
        groupToSave.members?.removeAll { $0.id == member.id }
        let result = await data.leaveGroupRepository(group: groupToSave, member: member)
        switch result {
            case .success(let bool):
                return .success(bool)
            case .failure(let error):
                return .failure(error)
        }
    }

    public func fetchGroupByMember(member: Member) async -> Result<ChallengeGroup, Error> {
        let result = await data.fetchGroupByMember(member: member)
        switch result {
        case .success(let group):
            return .success(group)
        case .failure(let error):
            return .failure(error)
        }
    }

    public func fetchGroupByID(id: String) async -> Result<ChallengeGroup, Error> {
        let result = await data.fetchGroupByID(id: id)
        switch result {
        case .success(let group):
            return .success(group)
        case .failure(let error):
            return .failure(error)
        }
    }


}



