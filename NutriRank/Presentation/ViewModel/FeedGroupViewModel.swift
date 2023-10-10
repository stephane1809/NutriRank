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
    @Published var members: [Member] = []
    @Published var member: Member = Member()

    let createUseCase: CreateChallengeGroupUseCase
    let createPostUseCase: CreateChallengePostUseCase
    let fetchUseCase: FetchChallengeGroupsUseCase
    let deleteUseCase: DeleteChallengeGroupUseCase
    let createMemberUseCase: CreateChallengeMemberUseCase
    let updateMemberUseCase: UpdateChallengeMemberUseCase
    let fetchMemberUseCase: FetchChallengeMemberUseCase

    public init(createUseCase: CreateChallengeGroupUseCase, createPostUseCase: CreateChallengePostUseCase, fetchUseCase: FetchChallengeGroupsUseCase, deleteUseCase: DeleteChallengeGroupUseCase, createMemberUseCase: CreateChallengeMemberUseCase, updateMemberUseCase: UpdateChallengeMemberUseCase, fetchMemberUseCase: FetchChallengeMemberUseCase) {
        self.createUseCase = createUseCase
        self.createPostUseCase = createPostUseCase
        self.fetchUseCase = fetchUseCase
        self.deleteUseCase = deleteUseCase
        self.createMemberUseCase = createMemberUseCase
        self.updateMemberUseCase = updateMemberUseCase
        self.fetchMemberUseCase = fetchMemberUseCase
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

    func createChallengeMember(name: String, avatar: String, score: Int ) async {
        var member = Member()
        member.name = name
        member.avatar = avatar
        member.score = score

        let result = await createMemberUseCase.execute(requestValue: member)

        switch result {
        case .success(let member):
            DispatchQueue.main.async {
                self.member = member
                UserDefaults.standard.set(member.id, forKey: "localMemberId")
            }
        case .failure(let error):
            print(error)
        }

    }

    func updateChallengeMember(score: Int) async {
        self.member.score = score
        let result = await updateMemberUseCase.execute(requestValue: self.member)
        
        switch result {
        case .success(let member):
            DispatchQueue.main.async {
                self.member = member
            }
        case .failure(let error):
            print(error)
        }

    }

    func fetchChallengeMember() async {
        let id = UserDefaults.standard.string(forKey: "localMemberId")

        guard let unwrappedId = id else {return}

        let result = await fetchMemberUseCase.execute(requestValue:unwrappedId)
        switch result {
        case .success(let member):
            DispatchQueue.main.async {
                self.member = member
            }
        case .failure(let error):
            print(error)
        }
    }
}
