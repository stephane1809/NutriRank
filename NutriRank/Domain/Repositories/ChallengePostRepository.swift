//
//  ChallengePostRepository.swift
//  NutriRankDomain
//
//  Created by Paulo Henrique Gomes da Silva on 20/09/23.
//  Copyright © 2023 com.merendeers. All rights reserved.
//

import Foundation

public protocol ChallengePostRepositoryProtocol {
    func createChallengePost(_ post: Post) async -> Result<Post, Error>
    func fetchAllPosts() async -> Result<[Post], Error>
    func getOwnersPost(_ member: Member) async -> Result<[Post], Error>
    func deleteChallengePost(_ post: Post) async -> Result<Bool, Error>
}

public class DefaultChallengePostRepository: ChallengePostRepositoryProtocol {
    let data: ChallengePostRepositoryProtocol

    public init(data: ChallengePostRepositoryProtocol) {
        self.data = data
    }

    public func createChallengePost(_ post: Post) async -> Result<Post, Error> {
        let result = await data.createChallengePost(post)
        switch result {
        case .success(let post):
            return .success(post)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    public func fetchAllPosts() async -> Result<[Post], Error> {
        let result = await data.fetchAllPosts()
        switch result {
        case .success(let posts):
            return .success(posts)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    public func getOwnersPost(_ member: Member) async -> Result<[Post], Error> {
        let result = await data.getOwnersPost(member)
        switch result {
        case .success(let posts):
            return .success(posts)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    public func deleteChallengePost(_ post: Post) async -> Result<Bool, Error> {
        let result = await data.deleteChallengePost(post)
        switch result {
        case .success(let bool):
            return .success(bool)
        case .failure(let error):
            return .failure(error)
        }
    }

}
