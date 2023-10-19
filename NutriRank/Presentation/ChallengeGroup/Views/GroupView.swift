//
//  GroupView.swift
//  NutriRankPresentation
//
//  Created by Stephane Girão Linhares on 04/10/23.
//  Copyright © 2023 com.merendeers. All rights reserved.
//

import Foundation
import SwiftUI

public struct GroupView: View {

    @ObservedObject var viewmodel: FeedGroupViewModel

    public init(viewmodel: FeedGroupViewModel) {
        self.viewmodel = viewmodel
    }

    public var body: some View {

        GeometryReader { metrics in
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
//                        Text(viewmodel.group.description)
//                            .lineLimit(1...10)
                    }
//                    .padding(.horizontal, 20)
//                    .padding(.vertical, 12)
//                    .frame(maxWidth: metrics.size.width * 0.92, minHeight: metrics.size.height * 0.09)
//                    .background(Color("DefaultCardColor"))
//                    .cornerRadius(10)
//                    .shadow(radius: 1, x: 0, y: 1)

                    VStack (alignment: .leading, spacing: 3){

                        HStack {
                            Image(systemName: "stopwatch.fill")
                            Text("Duração")
                                .bold()
                            Spacer()
                        }

                        Text("De \(viewmodel.group.startDate) a \(viewmodel.group.endDate)")
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
                            Text("Regras")
                                .bold()
                            Spacer()
                        }

                        Text("\(viewmodel.group.description)")
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
                            Text("Compartilhar")
                            Spacer()
                        }

                        Text("Convide seus amigos para participar de seu grupo novo e comecei o desafio!")
                            .lineLimit(1...10)
                        Spacer()

                            HStack {
//                                Text("Link")
//                                    .foregroundColor(.blue)
                                Button {
                                    guard let url = URL(string: "nutrirank://enter?id=\(viewmodel.group.id)") else { return }
                                    UIPasteboard.general.url = url
                                    print("link copiado")
                                } label: {
                                    Text("Copiar link")
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

                    }
                    .padding(.vertical,20)

                }
            }
            .frame(maxWidth: .infinity)
            .background(Color(.defaultBackground))
            .navigationTitle("Grupo")

        }
    }
}
