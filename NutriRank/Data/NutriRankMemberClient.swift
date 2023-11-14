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
            try await groupToSave.save(on: self.database)
            let values = AddMemberRequestedValues(member, groupToSave)
            return .success(values)
        } catch {
            return .failure(error)
        }
    }
    
    public func createChallengeMember(member: Member) async -> Result<Member, Error> {
        var memberToSave = member
        do {
            try await memberToSave.save(on: self.database)
            return .success(memberToSave)
        } catch {
            return .failure(error)
        }
    }

    public func updateChallengeMember(member: Member) async -> Result<Member, Error> {
        var memberToUpdate = member
        do {
            try await memberToUpdate.save(on: self.database)
            return .success(member)
        } catch {
            return .failure(error)
        }
    }

    public func fetchChallengeMember(id: String) async -> Result<Member, Error> {
        do {
            let fetchResult = try await Member.find(id: CKRecord.ID(recordName: id), on: self.database)
            return .success(fetchResult)

        } catch {
            return.failure(error)
        }
    }

}
