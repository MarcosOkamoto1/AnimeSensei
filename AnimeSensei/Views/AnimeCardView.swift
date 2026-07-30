//
//  AnimeCardView.swift
//  AnimeSensei
//
//  Created by Marcos Vinicius Alencar de Souza Okamoto on 29/07/26.
//

import SwiftUI

struct AnimeCardView: View {
    let anime: Anime
    var body: some View {
        HStack(alignment: .top, spacing: 12){
            AsyncImage(url:URL(string: anime.coverImage ?? ""))
            {phase in
                switch phase{
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                @unknown default:
                    EmptyView()
                }
                    
            }
            .frame(width: 100,height: 150)
            .clipped()
            .cornerRadius(6)
            VStack(alignment: .leading, spacing: 6){
                Text(anime.title)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                Text(anime.episodes.map{"\($0) Episodes"}
                     ?? "Unkonwn")
                .font(.subheadline)
                Text(anime.genres.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(anime.description ?? "No description available")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
            }
        }
        .padding()
    }
}
