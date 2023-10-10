//
//  NutriRankClient.swift
//  NutriRankKit
//
//  Created by Paulo Henrique Gomes da Silva on 15/09/23.
//  Copyright © 2023 Merendeers. All rights reserved.
//



import Foundation
import CloudKit
import Nuvem

public class NutriRankNuvemClient: ChallengeGroupRepositoryProtocol {
    
    let database = CKContainer(identifier: "iCloud.NutriRankContainer").publicCloudDatabase

    public init() {}

    public func createChallengeGroup(group: ChallengeGroup) async -> Result<ChallengeGroup, Error> {
        var groupToSave = group
        do {
            try await groupToSave.save(on: self.database)
            return .success(groupToSave)
        } catch {
            return .failure(error)
        }
    }

    public func fetchChallengeGroups() async -> Result<[ChallengeGroup], Error> {
        do {
            let result = try await ChallengeGroup.query(on: self.database).all()
            return(.success(result))

        } catch {
            return(.failure(error))
        }
    }

    public func deleteChallengeRepository(group: ChallengeGroup) async -> Result<Bool, Error> {
        do {
            try await group.delete(on: self.database)
            return .success(true)
        } catch {
            return .failure(error)
        }
    }

    public func fetchGroupByMember(member: Member) async -> Result<ChallengeGroup, Error> {
        do {
            let result = try await ChallengeGroup.query(on: self.database).all()
            return .success(ChallengeGroup())
        } catch {
            return .failure(error)
        }
    }

}
