//
//  FeedGroupView.swift
//  NutriRankPresentation
//
//  Created by Paulo Henrique Gomes da Silva on 19/09/23.
//  Copyright © 2023 Merendeers. All rights reserved.
//

import SwiftUI

public struct FeedGroupView: View {

    @ObservedObject var viewmodel: FeedGroupViewModel

    @State var isPresented: Bool = false
    @State var isActive: Bool = false
    @State var groupName: String = ""

    public init(viewmodel: FeedGroupViewModel) {
        self.viewmodel = viewmodel
    }

    public var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .top) {
                        Button("\(groupName)") {
                            isActive.toggle()
                            print("passou")
                        }.buttonStyle(NutriRankGroupButton(isActive: $isActive))
                    }.padding()
                }.scrollIndicators(.hidden)
            }.onAppear {
                Task {
                    if viewmodel.groups.isEmpty {
                        await viewmodel.fetchGroup()
                        groupName = viewmodel.groups[0].groupName
                    }
                }
            }.navigationTitle("NUTRIRANK")

        }
    }
}

struct NutriRankGroupButton: ButtonStyle {

    @Binding var isActive: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                RoundedRectangle(
                    cornerRadius: 12,
                    style: .continuous)
                .stroke($isActive.wrappedValue ? Color(.black) : Color(.red)).background(Color("lightBlue"))
            )
            .foregroundColor(.black)
    }
}

struct CreateGroupSheet: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject var viewModel: FeedGroupViewModel

    @State var groupName: String = ""
    @State var description: String = ""

    init(viewModel: FeedGroupViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        TextField("Nome do grupo", text: $groupName)
        TextField("Descrição do grupo", text: $description)
        Button {
            Task {
//                await viewModel.createGroup(groupName: groupName, description: description, )
            }
            dismiss()
        } label: {
            Text("Criar o grupo")
        }.buttonStyle(.borderedProminent)
    }
}
