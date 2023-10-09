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
        var memberToSave = Member()
        memberToSave.name = member.name
        memberToSave.avatar = member.avatar
        memberToSave.score = member.score
        let database = CKContainer(identifier: "iCloud.NutriRankContainer").publicCloudDatabase
        do {
            try await memberToSave.save(on: database)
            return .success(memberToSave)
        } catch {
            return .failure(error)
        }
    }
}
