//
//  ContentView.swift
//  AnimeSensei
//
//  Created by Marcos Vinicius Alencar de Souza Okamoto on 28/07/26.
//

import SwiftUI

struct ContentView: View {
    @State private var searchtext: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("What are you looking to watch today?")
                        .font(.largeTitle)
                        .bold()
                    TextField("What is in your mind?", text: $searchtext)
                        .textFieldStyle(.roundedBorder)

                    NavigationLink {
                        ResultsView(searchText: searchtext)
                    } label: {
                        Text("Search")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(searchtext.isEmpty)
                    .foregroundStyle(Color .white)
                }
            }
            .padding()

        }
    }
}

#Preview {
    ContentView()
}
