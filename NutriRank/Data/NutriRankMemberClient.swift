//
//  NutriRankMemberClient.swift
//  NutriRank
//
//  Created by Gabriel Santiago on 09/10/23.
//

import Foundation
import CloudKit
import Nuvem


public class NutriRankMemberClient: ChallengeMemberRepositoryProtocol {

    let database = CKContainer(identifier: "iCloud.NutriRankContainer").publicCloudDatabase

    public func addMemberToGroup(member: Member, group: ChallengeGroup) async -> Result<AddMemberRequestedValues, Error> {
        do {
            var groupToSave = group
            var memberToSave = member
            try await groupToSave.save(on: database)
            try await memberToSave.save(on: database)
            let values = AddMemberRequestedValues(memberToSave, groupToSave)
            return .success(values)
        } catch {
            return .failure(error)
        }
    }
    
    public func createChallengeMember(member: Member) async -> Result<Member, Error> {
        var memberToSave = member
        let database = CKContainer(identifier: "iCloud.NutriRankContainer").publicCloudDatabase
        do {
            try await memberToSave.save(on: database)
            return .success(memberToSave)
        } catch {
            return .failure(error)
        }
    }

    public func updateChallengeMember(member: Member) async -> Result<Member, Error> {
        var memberToUpdate = member
        let database = CKContainer(identifier: "iCloud.NutriRankContainer").publicCloudDatabase
        do {
            try await memberToUpdate.save(on: database)
            return .success(member)
        } catch {
            return .failure(error)
        }
    }

    public func fetchChallengeMember(id: String) async -> Result<Member, Error> {
        let database = CKContainer(identifier: "iCloud.NutriRankContainer").publicCloudDatabase
        do {
            let fetchResult = try await Member.find(id: CKRecord.ID(recordName: id), on: database)
            return .success(fetchResult)

        } catch {
            return.failure(error)
        }
    }

}
