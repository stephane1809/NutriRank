//
//  NutriRankClient.swift
//  NutriRankKit
//
//  Created by Paulo Henrique Gomes da Silva on 15/09/23.
//  Copyright © 2023 Merendeers. All rights reserved.
//



import Foundation
import CloudKit

public class NutriRankNuvemClient: ChallengeGroupRepositoryProtocol {


    public init() {}

    public func createChallengeGroup(group: ChallengeGroup) async -> Result<ChallengeGroup, Error> {
        print("chegou no cliente")
        var groupToSave = ChallengeGroup()
        groupToSave.groupName = group.groupName
        groupToSave.description = group.description
        let database = CKContainer(identifier: "iCloud.NutriRankContainer").publicCloudDatabase
        do {
            try await groupToSave.save(on: database)
            return .success(groupToSave)
        } catch {
            return .failure(error)
        }
    }

    public func fetchChallengeGroups() async -> Result<[ChallengeGroup], Error> {
        print("fetch chegou no cliente")
        let database = CKContainer(identifier:"iCloud.NutriRankContainer").publicCloudDatabase
        do{
            let result = try await ChallengeGroup.query(on: database).all()
            return(.success(result))

        } catch {
            return(.failure(error))
        }
    }

    public func deleteChallengeRepository(group: ChallengeGroup) async -> Result<Bool, Error> {
        print("delete chegou no client")
        let database = CKContainer(identifier: "iCloud.NutriRankContainer").publicCloudDatabase
        do {
            try await group.delete(on: database)
            return .success(true)
        } catch {
            return .failure(error)
        }
    }



}
