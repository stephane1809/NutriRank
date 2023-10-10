//
//  NutriRankClientPosts.swift
//  NutriRankDomain
//
//  Created by Paulo Henrique Gomes da Silva on 20/09/23.
//  Copyright © 2023 com.merendeers. All rights reserved.
//

import Foundation
import CloudKit
import Nuvem

public class NutriRankClientPosts: ChallengePostRepositoryProtocol {

    let identifier: String = "iCloud.NutriRankContainer"

    public init() { }

    public func createChallengePost(_ post: Post) async -> Result<Post, Error> {
        do {
            let database = CKContainer(identifier: identifier).publicCloudDatabase
            var postToSave = post
            try await postToSave.save(on: database)
            return .success(postToSave)
        } catch {
            return .failure(error)
        }
    }
    
    public func fetchAllPosts() async -> Result<[Post], Error> {
        do {
            let database = CKContainer(identifier: identifier).publicCloudDatabase
            let result = try await Post.query(on: database).all()
            return .success(result)
        } catch {
            return .failure(error)
        }
    }

    public func getOwnersPost(_ member: Member) async -> Result<[Post], Error> {
        let database = CKContainer(identifier: identifier).publicCloudDatabase
        do {
            let result = try await Post
                .query(on: database)
                .filter(\.$owner == member)
                .with(\.$owner)
                .all()
            return .success(result)
        } catch {
            return .failure(error)
        }
    }

    public func deleteChallengePost(_ post: Post) async -> Result<Bool, Error> {
        let database = CKContainer(identifier: identifier).publicCloudDatabase
        do {
            try await post.delete(on: database)
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
}
