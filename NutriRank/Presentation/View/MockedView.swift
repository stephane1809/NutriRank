//
//  MockedView.swift
//  NutriRank
//
//  Created by Gabriel Santiago on 09/10/23.
//

import SwiftUI

struct MockedView: View {

    @ObservedObject var viewmodel: FeedGroupViewModel

    init(viewmodel: FeedGroupViewModel) {
        self.viewmodel = viewmodel
        
    }
    var body: some View {
        Button("Criar usuario") {
            Task {

                await viewmodel.createChallengeMember(name: "garotão", avatar: "rato alado", score: 200)
            }
        }
    }
}
