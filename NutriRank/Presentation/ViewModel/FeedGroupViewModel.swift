//
//  FeedGroupViewModel.swift
//  NutriRankPresentation
//
//  Created by Paulo Henrique Gomes da Silva on 19/09/23.
//  Copyright © 2023 Merendeers. All rights reserved.
//

import Foundation
import UIKit

public class FeedGroupViewModel: ObservableObject {
    @Published var groups: [ChallengeGroup] = []
    @Published var group: ChallengeGroup = ChallengeGroup()
    @Published var posts: [Post] = []
    @Published var groupIDToAddMember: String?

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

    func handle(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let scheme = components.scheme, scheme == "nutrirank",
              let action = components.host,
              let params = components.queryItems else {
            print("Invalid URL")
            return
        }

        switch action {
        case "enter":
            if let firstParam = params.first, let id = firstParam.value, firstParam.name == "id" {
                print("add new member to group \(id)")
                groupIDToAddMember = id
            }
        default:
            print("Unhandled action: \(url)")
        }
    }

    func createGroup(groupName: String, description: String, image: UIImage?) async {
        print("chegou na viewmodel")
        var group = ChallengeGroup()
        group.groupName = groupName
        group.description = description
        group.groupImage = image
        let result = await createUseCase.execute(requestValue: group)
        switch result {
        case .success(let group):
            DispatchQueue.main.async {
                self.group = group
            }
            print("Operação realizada com sucesso.")
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
                    self.group = self.groups[0]
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
