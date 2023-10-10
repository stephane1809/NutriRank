//
//  MockedView.swift
//  NutriRank
//
//  Created by Gabriel Santiago on 09/10/23.
//

import SwiftUI

struct MockedView: View {

    @ObservedObject var viewmodel: FeedGroupViewModel
    @State var member: Member = Member()


    init(viewmodel: FeedGroupViewModel) {
        self.viewmodel = viewmodel
        
    }
    var body: some View {
        VStack{
            Button("Criar usuario") {
                Task {
                    member.avatar = "fotinhazinha"
                    member.name = "pepito jordano"
                    member.score = 500
                    await viewmodel.createChallengeMember(name: member.name, avatar: member.avatar, score: member.score)
                }
            }

            Button("Atualizar usuario") {
                Task {
                    member.score = 200000
                    await viewmodel.updateChallengeMember(score: member.score)
                }
            }

            Button("Puxa usuario") {
                Task {
                    await viewmodel.fetchChallengeMember()
                    print(viewmodel.member.score)

                }
            }
        }
    }
}
