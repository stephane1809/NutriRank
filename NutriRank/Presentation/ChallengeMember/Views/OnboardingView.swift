//
//  OnboardingView.swift
//  NutriRankPresentation
//
//  Created by Stephane Girão Linhares on 03/10/23.
//  Copyright © 2023 com.merendeers. All rights reserved.
//

import Foundation
import SwiftUI
import Mixpanel

public struct OnboardingView: View {


    let viewModel: FeedGroupViewModel

    public var body: some View {

            GeometryReader { metrics in
                    ZStack {
                        Color(.defaultBackground)
                            .ignoresSafeArea()

                        VStack (spacing: 110) {
                            VStack {
                                Image("logo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Rectangle())
                                    .scaledToFill()
                                    .frame(width: metrics.size.width * 0.6, height: metrics.size.height * 0.25)
                                Text("O desafio perfeito para sua saúde.")
                                

                            }

                            VStack {
                                NavigationLink(destination: CreateProfileView(viewModel: viewModel)){
                                    Text("Começar")
                                        .font(.headline)
                                        .frame(width: 250, height: 35)
                                        .foregroundColor(.white)
                                }
                                .background(Color("actionButton"))
                                .cornerRadius(10)
                                .buttonStyle(.bordered)

                            }
                        }
                    }
                    .onAppear {
                        Mixpanel.mainInstance().track(event: "Onboarding View", properties: MixpanelProductionIndicator.Production.retrieveDict())
                    }
            }

    }
}
