//
//  FeedGroupViewModel.swift
//  NutriRankPresentation
//
//  Created by Paulo Henrique Gomes da Silva on 19/09/23.
//  Copyright © 2023 Merendeers. All rights reserved.
//

import Foundation

public class FeedGroupViewModel: ObservableObject {
    @Published var groups: [ChallengeGroup] = []
    @Published var posts: [Post] = []

    let createUseCase: CreateChallengeGroupUseCase
    let createPostUseCase: CreateChallengePostUseCase
    let fetchUseCase: FetchChallengeGroupsUseCase
    let deleteUseCase: DeleteChallengeGroupUseCase

    public init(createUseCase: CreateChallengeGroupUseCase,
                createPostUseCase: CreateChallengePostUseCase,
                fetchUseCase: FetchChallengeGroupsUseCase,
                deleteUseCase: DeleteChallengeGroupUseCase) {
        self.createUseCase = createUseCase
        self.createPostUseCase = createPostUseCase
        self.fetchUseCase = fetchUseCase
        self.deleteUseCase = deleteUseCase
    }

    func createGroup(groupName: String, description: String) async {
        print("chegou na viewmodel")
        var group = ChallengeGroup()
        group.groupName = groupName
        group.description = description
        let result = await createUseCase.execute(requestValue: group)
        switch result {
        case .success(let group):
            DispatchQueue.main.async {
                self.groups.append(group)
            }
        case .failure(let error):
            print(error)
        }
    }

    func fetchGroup() async {
        print("o fetch chegou na viewmodel")
        let result = await fetchUseCase.execute()
        switch result {
            case .success(let groupList):
                DispatchQueue.main.async {
                    self.groups = groupList
                    print(self.groups[0].id)
                }
            case .failure(let error):
                print(error)
        }
    }

    func deleteGroup(group: ChallengeGroup) async {
        print("o delete chegou na viewmodel")
        let result = await deleteUseCase.execute(group: group)
        switch result {
            case .success(let bool):
                print(bool)
            case .failure(let error):
                print(error)
        }
    }
    
    func createPost(title: String, description: String) async {
        var post = Post()
        post.description = description
        post.title = title
        let result = await createPostUseCase.execute(post)
        switch result {
        case .success(let post):
            DispatchQueue.main.async {
                self.posts.append(post)
            }
        case .failure(let error):
            print(error)
        }
    }
}
