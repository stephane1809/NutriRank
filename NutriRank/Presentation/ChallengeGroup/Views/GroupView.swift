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

    public init() {}


    public var body: some View {
        
        GeometryReader { metrics in
            NavigationView {
                ScrollView {
                    VStack (spacing: 20) {
                        Image(systemName: "camera.fill").font(.system(size: 37, weight: .regular))
                            .aspectRatio(contentMode: .fit)
                            .scaledToFill()
                            .frame(width: metrics.size.width * 0.92, height: metrics.size.height * 0.20)
                            .background(Color("Green"))
                            .cornerRadius(10)

                        VStack (alignment: .leading, spacing: 3){
                            Text ("Nome do grupo")
                                .font(.title2)
                                .bold()
                            Text("Descrição do grupo bubiubuibuibui isdjncisdncisnducbnsoiudbcusdocisnodicnosidncoisndcinsdiocnincoinsdocnosidnci")
                                .lineLimit(1...10)

                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .frame(maxWidth: metrics.size.width * 0.92, minHeight: metrics.size.height * 0.09)
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(radius: 1, x: 0, y: 1)

                        VStack (alignment: .leading, spacing: 3){

                            HStack {
                                Image(systemName: "stopwatch.fill")
                                Text("Duração")
                                    .bold()
                                Spacer()
                            }

                            Text("De tal dia a tal dia")
                                .lineLimit(1...10)


                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .frame(maxWidth: metrics.size.width * 0.92, minHeight: metrics.size.height * 0.09)
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(radius: 1, x: 0, y: 1)

                        VStack (alignment: .leading, spacing: 3){

                            HStack {
                                Image(systemName: "flame.fill")
                                Text("Regras")
                                    .bold()
                                Spacer()
                            }

                            Text("Regras do grupo wnxubwubxuybdcuybeduycbuebcybuycbrue")
                                .lineLimit(1...10)

                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .frame(maxWidth: metrics.size.width * 0.92, minHeight: metrics.size.height * 0.09)
                        .background(.white)
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
                                Text("Link")
                                    .foregroundColor(.blue)
                                Button {

                                } label: {
                                    Text("Copiar link")
                                        .font(.headline)
                                        .frame(width: 110, height: 22)
                                        .foregroundColor(.white)
                                }
                                .background(.blue)
                                .cornerRadius(10)
                                .buttonStyle(.bordered)
                                Spacer()
                            }

                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .frame(maxWidth: metrics.size.width * 0.92, minHeight: metrics.size.height * 0.09)
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(radius: 1, x: 0, y: 1)

                        VStack {
                            Button {

                            } label: {

                                    Image(systemName: "trophy.fill").font(.system(size: 25, weight: .regular))
                                        .foregroundColor(.white)
                                    Text("Ranking")
                                        .font(.title2)
                                        .foregroundColor(.white)

                            }
                            .background(.blue)
                            .cornerRadius(10)
                            .buttonStyle(.bordered)
                        }
                        .padding(.vertical,20)

                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color("Light blue"))
                .navigationTitle("Grupo")
            }
        }
    }
}
