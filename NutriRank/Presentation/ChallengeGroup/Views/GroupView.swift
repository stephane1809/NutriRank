//
//  GroupView.swift
//  NutriRankPresentation
//
//  Created by Stephane Girão Linhares on 04/10/23.
//  Copyright © 2023 com.merendeers. All rights reserved.
//

import Foundation
import SwiftUI
import Mixpanel

public struct GroupView: View {

    @Environment(\.dismiss) var dismiss

    @Binding var leavedGroup: Bool

    @ObservedObject var viewmodel: FeedGroupViewModel

    public init(viewmodel: FeedGroupViewModel, _ performNavigation: Binding<Bool>) {
        self.viewmodel = viewmodel
        self._leavedGroup = performNavigation
    }

    public var body: some View {

        GeometryReader { metrics in
            ZStack {
                ScrollView {
                    VStack (spacing: 20) {
                        Image(uiImage: viewmodel.group.groupImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Rectangle())
                            .scaledToFill()
                            .frame(width: metrics.size.width * 0.92, height: metrics.size.height * 0.20)
                            .cornerRadius(10)

                        VStack (alignment: .leading, spacing: 3){
                            Text (viewmodel.group.groupName)
                                .font(.title2)
                                .bold()
                        }

                        VStack (alignment: .leading, spacing: 3){

                            HStack {
                                Image(systemName: "stopwatch.fill")
                                    .foregroundColor(.black)
                                Text("Duração")
                                    .foregroundColor(.black)
                                    .bold()
                                Spacer()
                            }

                            Text(viewmodel.formatedIntervalDates(startDate: viewmodel.group.startDate, endDate: viewmodel.group.endDate))
                                .foregroundColor(.black)
                                .lineLimit(1...10)

                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .frame(maxWidth: metrics.size.width * 0.92, minHeight: metrics.size.height * 0.09)
                        .background(Color("DefaultCardColor"))
                        .cornerRadius(10)
                        .shadow(radius: 1, x: 0, y: 1)

                        VStack (alignment: .leading, spacing: 3){

                            HStack {
                                Image(systemName: "flame.fill")
                                    .foregroundColor(.black)
                                Text("Regras")
                                    .foregroundColor(.black)
                                    .bold()
                                Spacer()
                            }

                            Text("\(viewmodel.group.description)")
                                .foregroundColor(.black)
                                .lineLimit(1...10)

                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .frame(maxWidth: metrics.size.width * 0.92, minHeight: metrics.size.height * 0.09)
                        .background(Color("DefaultCardColor"))
                        .cornerRadius(10)
                        .shadow(radius: 1, x: 0, y: 1)

                        VStack (alignment: .leading, spacing: 2) {

                            HStack {
                                Image(systemName: "paperplane.fill")
                                    .foregroundColor(.black)
                                Text("Compartilhar")
                                    .foregroundColor(.black)
                                Spacer()
                            }

                            Text("Convide seus amigos para participar de seu grupo novo e comecei o desafio!")
                                .foregroundColor(.black)
                                .lineLimit(1...10)
                            Spacer()
                            HStack {
                                Button {
                                    let groupID = viewmodel.group.id
                                    UIPasteboard.general.string = groupID
                                    viewmodel.linkWasCopied = true
                                } label: {
                                    Text("Copiar ID")
                                        .font(.headline)
                                        .frame(width: 110, height: 22)
                                        .foregroundColor(.white)
                                }
                                .background(Color("FirstPlaceRanking"))
                                .cornerRadius(10)
                                .buttonStyle(.bordered)
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .frame(maxWidth: metrics.size.width * 0.92, minHeight: metrics.size.height * 0.09)
                        .background(Color("DefaultCardColor"))
                        .cornerRadius(10)
                        .shadow(radius: 1, x: 0, y: 1)

                        VStack {
                            NavigationLink(destination: RankingView(viewmodel: viewmodel)) {
                                Image(systemName: "trophy.fill").font(.system(size: 23, weight: .regular))
                                    .foregroundColor(.white)
                                Text("Ranking")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                            .background(Color("FirstPlaceRanking"))
                            .cornerRadius(10)
                            .buttonStyle(.bordered)
                            .simultaneousGesture(
                            TapGesture()
                                .onEnded {
                                    Mixpanel.mainInstance().track(event: "Tapped Ranking Button", properties: MixpanelProductionIndicator.Production.retrieveDict())
                                }
                        )
                            Button("Sair do grupo") {
                                Task {
                                    let result = await viewmodel.leaveGroup()
                                    if result {
                                        self.leavedGroup = true
                                        dismiss()
                                    }
                                }
                            }
                            .foregroundStyle(.firstPlaceRanking)
                            .underline()
                            .padding()
                        }
                        .padding(.vertical,20)
                        CopyToClipboardView(enabled: $viewmodel.linkWasCopied)
                    }
                }
                .navigationDestination(isPresented: $leavedGroup, destination: { EmptyStateView(viewmodel: viewmodel) })
            }
            .frame(maxWidth: .infinity)
            .background(Color(.defaultBackground))
            .navigationTitle("Grupo")
            .onAppear{
                Mixpanel.mainInstance().track(event: "Group View", properties: MixpanelProductionIndicator.Production.retrieveDict())
            }
        }
    }
}
