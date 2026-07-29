//
//  AnimeDetailView.swift
//  AnimeSensei
//
//  Created by Marcos Vinicius Alencar de Souza Okamoto on 28/07/26.
//

import SwiftUI

struct AnimeDetailView: View {
    let anime: Anime
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 16 ){
                Text(anime.title)
                    .font(.title)
                    .bold()
                
                Text("\(anime.episodes ?? 0 ) Episodes")
                    .foregroundStyle(.secondary)
                
                Text(anime.genres.joined(separator: ", "))
                    .font(.subheadline)
                
                Divider()
                
                Text("Sinopse")
                    .font(.title2)
                    .bold()
                
                Text(anime.description ?? "No description available")
                
            }
            .padding()
        }
    }
}

