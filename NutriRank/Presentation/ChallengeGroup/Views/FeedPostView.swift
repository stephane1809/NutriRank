//
//  FeedPostView.swift
//  NutriRank
//
//  Created by Stephane Girão Linhares on 09/10/23.
//

import Foundation
import SwiftUI

public struct FeedPostView: View {

    public init() {}

    @State var card = CardPostView()

    public var body: some View {
        GeometryReader { metrics in
            NavigationView  {
                ZStack {
                    Color(.defaultBackground)
                        .ignoresSafeArea()
                    VStack (alignment: .center){
                        card
                    
                    }
                }
            }
        }
    }
}
