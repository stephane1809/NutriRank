//
//  EmptyStateView.swift
//  NutriRankPresentation
//
//  Created by Stephane Girão Linhares on 03/10/23.
//  Copyright © 2023 com.merendeers. All rights reserved.
//

import Foundation
import SwiftUI

public struct EmptyStateView: View {

    @ObservedObject var viewmodel: FeedGroupViewModel

    public init(viewmodel: FeedGroupViewModel) {
        self.viewmodel = viewmodel
    }

    public var body: some View {
        GeometryReader { metrics in
            NavigationStack {
                ZStack {
                    
                        Color(.defaultBackground)
                            .ignoresSafeArea()

                        VStack (spacing: 50) {
                            VStack {
                                Image("logo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Rectangle())
                                    .scaledToFill()
                                    .frame(width: metrics.size.width * 0.6, height: metrics.size.height * 0.25)
                            }

                            VStack (alignment: .leading) {
                                HStack {
                                    Image(systemName: "person.crop.circle.fill.badge.plus").font(.system(size: 18, weight: .regular))
                                        .aspectRatio(contentMode: .fit)
                                        .scaledToFill()

                                    Text ("Crie um grupo")
                                        .font(.headline)
                                }
                                Text("Você não possui grupos no momento. Crie num novo grupo e inicie novos hábitos alimentares com seus amigos!")
                            }
                            .padding(.horizontal, 15)
                            .padding(.vertical, 12)
                            .frame(maxWidth: metrics.size.width * 0.92, minHeight: metrics.size.height * 0.09)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 1, x: 0, y: 1)


                            VStack {

                                NavigationLink(destination: CreateGroupView(viewmodel: viewmodel)) {
                                    HStack (alignment: .center){
                                        Image(systemName: "person.crop.circle.fill.badge.plus")
                                            .foregroundColor(.white)

                                        Text("Criar grupo")
                                            .font(.headline)

                                            .foregroundColor(.white)
                                    }
                                    .frame(width: 150, height: 35)
                                }
                                .background(Color("FirstPlaceRanking"))
                                .cornerRadius(10)
                                .buttonStyle(.bordered)
                            }
                        }


                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            Task {
                await viewmodel.fetchChallengeMember()
                await viewmodel.fetchGroupByMember()
            }
        }
        .onOpenURL(perform: { url in
            Task {
                await viewmodel.handle(url: url)
            }
        })
    }

}
