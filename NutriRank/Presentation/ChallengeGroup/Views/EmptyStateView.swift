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
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewmodel: FeedGroupViewModel
    @State var performNavigation: Bool = false
    @State var showSheet: Bool = false
    @State var groupID: String = ""
    @State var showAlert: Bool = false
    @State var message: String = ""

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
                            Text("Você não possui grupos no momento. Crie um novo grupo, ou entre em um existente, e inicie novos hábitos alimentares com seus amigos!")
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .frame(maxWidth: metrics.size.width * 0.92, minHeight: metrics.size.height * 0.09)
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(radius: 1, x: 0, y: 1)
                        VStack {
                            HStack {
                                NavigationLink(destination: CreateGroupView(viewmodel: viewmodel)) {
                                    HStack (alignment: .center) {
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
                                Button {
                                    self.showSheet.toggle()
                                } label: {
                                    HStack(alignment: .center) {
                                        Image(systemName: "person.3.fill")
                                            .foregroundStyle(.white)
                                        Text("Entrar")
                                            .font(.headline)
                                            .foregroundStyle(.white)
                                    }
                                    .frame(width: 150, height: 35)
                                }
                                .background(.firstPlaceRanking)
                                .clipShape(.rect(cornerRadius: 10))
                                .buttonStyle(.bordered)
                                .sheet(isPresented: $showSheet, content: {
                                    Form {
                                        VStack(alignment: .center) {
                                            Section("Entre em um grupo") {
                                                    TextField("ID do grupo", text: $groupID)
                                            }
                                            Button {
                                                Task {
                                                    if !(self.groupID == "") {
                                                        await viewmodel.fetchGroupByID(id: self.groupID)
                                                        if await viewmodel.addMemberToGroup(member: self.viewmodel.member, group: self.viewmodel.group) {
                                                            showSheet.toggle()
                                                            if viewmodel.group.record != nil {
                                                                await viewmodel.fetchGroupByMember()
                                                                self.performNavigation.toggle()
                                                            }
                                                        } else {
                                                            self.message = "Erro ao entrar no grupo."
                                                            self.showAlert.toggle()
                                                        }
                                                    } else {
                                                        print(self.groupID)
                                                        self.message = "ID mal formatado."
                                                        self.showAlert.toggle()
                                                    }
                                                }
                                            } label: {
                                                HStack(alignment: .center) {
                                                    Text("Entrar")
                                                        .font(.headline)
                                                        .foregroundStyle(.white)
                                                }
                                                    .frame(width: 100, height: 35)
                                            }
                                            .background(.firstPlaceRanking)
                                            .clipShape(.rect(cornerRadius: 10))
                                            .buttonStyle(.bordered)
                                            .alert("Erro ao entrar", isPresented: $showAlert) {
                                                Text(self.message)
                                                Button("Cancelar", role: .cancel){}
                                            }
                                        }
                                    }
                                    .presentationDetents([.medium, .large])
                                })

                            }
                        }
                    }
                }
                .navigationDestination(isPresented: $performNavigation, destination: {FeedPostView(viewmodel: viewmodel)})
            }
            .navigationBarBackButtonHidden(true)
        }
        .task {
            await viewmodel.fetchChallengeMember()
            await viewmodel.fetchGroupByMember()
            if viewmodel.group.record != nil {
                self.performNavigation.toggle()
            }
        }
        .onOpenURL(perform: { url in
            Task {
                await viewmodel.handle(url: url)
            }
        })
    }

}
