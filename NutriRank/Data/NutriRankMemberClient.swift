//
//  NutriRankMemberClient.swift
//  NutriRank
//
//  Created by Gabriel Santiago on 09/10/23.
//

import Foundation
import CloudKit


public class NutriRankMemberClient: ChallengeMemberRepositoryProtocol {
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

    public func fetchChallengeMember(member:Member) async -> Result<Member, Error> {
        var memberToFetch = member
        let database = CKContainer(identifier: "iCloud.NutriRankContainer").publicCloudDatabase
        do {

        } catch {
            return.failure(error)
        }
    }

}
