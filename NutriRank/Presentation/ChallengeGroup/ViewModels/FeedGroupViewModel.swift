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
    @Published var members: [Member] = []
    @Published var member: Member = Member()
    @Published var linkWasCopied: Bool = false
    var leavedGroup: Bool = false
    var cache = NSCache<NSString, ChallengeGroup>()

    var sortedRankingGroup: [Member] {
        guard let unpackedArray = group.members else {return []}
        
        let unpackedSortedArray = unpackedArray.sorted {$0.score > $1.score }
        return unpackedSortedArray
    }

    var sortedPostForDate: [Post] {
        let postsArray = posts

        let sortedPostsArray = postsArray.sorted {$0.creationDate! > $1.creationDate!}
        return sortedPostsArray
    }

    func getNamePersonRanking(index: Int) -> String {
            var personRanking: String
            let numberOfMembers: Int = sortedRankingGroup.count
            let maxIndexPossible: Int = numberOfMembers - 1

            if index <= maxIndexPossible {
                personRanking = sortedRankingGroup[index].name
            } else {
                personRanking = "-"
            }
            return personRanking
    }

    let createUseCase: CreateChallengeGroupUseCase
    let createPostUseCase: CreateChallengePostUseCase
    let fetchUseCase: FetchChallengeGroupsUseCase
    let deleteUseCase: LeaveGroupUseCaseProtocol
    let createMemberUseCase: CreateChallengeMemberUseCase
    let updateMemberUseCase: UpdateChallengeMemberUseCase
    let fetchMemberUseCase: FetchChallengeMemberUseCase
    let fetchGroupByIDUseCase: FetchGroupByIdUseCaseProtocol
    let addMemberUseCase: AddMemberToGroupUseCaseProtocol
    let fetchPostsByGroup: FetchChallengePostsUseCaseProtocol
    let fetchGroupByMember: FetchGroupByMemberUseCaseProtocol
    let deletePostUseCase: DeleteChallengePostUseCaseProtocol

    public init(createUseCase: CreateChallengeGroupUseCase, 
                createPostUseCase: CreateChallengePostUseCase,
                fetchUseCase: FetchChallengeGroupsUseCase,
                deleteUseCase: LeaveGroupUseCaseProtocol,
                createMemberUseCase: CreateChallengeMemberUseCase,
                updateMemberUseCase: UpdateChallengeMemberUseCase,
                fetchMemberUseCase: FetchChallengeMemberUseCase,
                fetchGroupByIDUseCase: FetchGroupByIdUseCaseProtocol,
                addMemberUseCase: AddMemberToGroupUseCaseProtocol,
                fetchPostsByGroup: FetchChallengePostsUseCaseProtocol,
                fetchGroupByMember: FetchGroupByMemberUseCaseProtocol,
                deletePostUseCase: DeleteChallengePostUseCaseProtocol) {
        self.createUseCase = createUseCase
        self.createPostUseCase = createPostUseCase
        self.fetchUseCase = fetchUseCase
        self.deleteUseCase = deleteUseCase
        self.createMemberUseCase = createMemberUseCase
        self.updateMemberUseCase = updateMemberUseCase
        self.fetchMemberUseCase = fetchMemberUseCase
        self.fetchGroupByIDUseCase = fetchGroupByIDUseCase
        self.addMemberUseCase = addMemberUseCase
        self.fetchPostsByGroup = fetchPostsByGroup
        self.fetchGroupByMember = fetchGroupByMember
        self.deletePostUseCase = deletePostUseCase
        group.groupName = ""
        group.description = ""
        group.members = []
    }

    func handle(url: URL) async {
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
                await fetchGroupByID(id: id)
                if await addMemberToGroup(member: self.member, group: self.group) {
                    print("success")
                }
            }
        default:
            print("Unhandled action: \(url)")
        }
    }

    @MainActor func addMemberToGroup(member: Member, group: ChallengeGroup) async -> Bool {
        let result = await addMemberUseCase.execute(requestValue: AddMemberRequestedValues(member, group))
        switch result {
        case .success(let values):
            self.group = values.group
            self.cache.setObject(values.group, forKey: NSString(string: values.group.id))
            UserDefaults.standard.set(values.group.id, forKey: "IDGroup")
            self.member = values.member
            return true
        case .failure(let error):
            print(error)
            return false
        }
    }

    func createGroup(groupName: String, description: String, image: UIImage?, startDate: Date, endDate: Date, duration: Int) async -> Bool{
        var group = ChallengeGroup()
        group.groupName = groupName
        group.description = description
        group.groupImage = image
        group.startDate = startDate
        group.endDate = endDate
        group.duration = duration
        let members = [self.member]
        group.members = members
        let result = await createUseCase.execute(requestValue: group)
        switch result {
        case .success(let group):
            DispatchQueue.main.async {
                self.group = group
            }
                return true
        case .failure(let error):
            print(error)
                return false
        }
    }

    func leaveGroup() async -> Bool {
        let result = await deleteUseCase.execute(group: self.group, member: self.member)
        switch result {
        case .success(let bool):
            return bool
        case .failure(let error):
            print(error)
            return false
        }
    }

    func fetchPosts() async {
        let result = await fetchPostsByGroup.execute(requestValue: self.group.id)
        switch result {
        case .success(let posts):
            DispatchQueue.main.async {
                self.posts = posts
            }
        case .failure(let error):
            print(error)
        }
    }

    @MainActor func fetchGroup() async {
        let result = await fetchUseCase.execute()
        switch result {
            case .success(let groupList):
//                DispatchQueue.main.async {
                    self.groups = groupList
//                }
            case .failure(let error):
                print(error)
        }
    }

    @MainActor func fetchGroupByID(id: String) async {
        let result = await fetchGroupByIDUseCase.execute(requestValue: id)
        switch result {
        case .success(let group):
//            DispatchQueue.main.async {
                self.group = group
//            }
        case .failure(let error):
            print(error)
        }
    }

    func createPost(title: String, description: String, postImage: UIImage?) async -> Bool {
        var post = Post()
        post.description = description
        post.title = title
        post.postImage = postImage
        post.owner = self.member
        post.challengeGroup = self.group
        let result = await createPostUseCase.execute(post)
        switch result {
        case .success(let post):
            DispatchQueue.main.async {
                self.posts.append(post)
            }
            return true
        case .failure(let error):
            print(error)
            return false
        }
    }

    func createChallengeMember(name: String, avatar: UIImage?, score: Int ) async -> Bool{
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
                return true
        case .failure(let error):
            print(error)
                return false
        }

    }

    func updateChallengeMember() async {
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

    func fetchMemberByID(id: String) async {
        let result = await fetchMemberUseCase.execute(requestValue: id)
        switch result {
        case .success(let member):
            DispatchQueue.main.async {
                self.member = member
            }
        case .failure(let error):
            print(error)
        }
    }

    @MainActor func fetchGroupByMember() async -> Bool {
        let result = await fetchGroupByMember.execute(requestValue: self.member)
        switch result {
        case .success(let group):
            self.group = group
            return true
        case .failure(let error):
            print(error)
            return false
        }
    }

    func getCachedGroup() -> Bool {
        guard let IDGroup = UserDefaults.standard.value(forKey: "IDGroup") else { return false }
        guard let cachedGroup = self.cache.object(forKey: NSString(string: "\(IDGroup)")) else { return false }
        self.group = cachedGroup
        UserDefaults.standard.removeObject(forKey: "IDGroup")
        self.cache.removeAllObjects()
        return true
    }

    func resetGroup() {
        var group = ChallengeGroup()
        group.groupName = ""
        group.description = ""
        group.members = []
        self.group = group
        self.leavedGroup = false
    }

    func deletePost(post: Post) async -> Bool {
        let result = await deletePostUseCase.execute(post)
        switch result {
        case .success(let bool):
            return bool
        case .failure(let error):
            print(error)
            return false
        }
    }

    func formatedIntervalDates(startDate: Date, endDate: Date) -> Date.IntervalFormatStyle.FormatOutput {
        var dates = (startDate..<endDate).formatted(.interval.day().month().year())
        return dates
    }
}
