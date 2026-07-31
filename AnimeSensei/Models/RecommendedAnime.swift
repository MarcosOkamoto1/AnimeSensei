//
//  Recommendations.swift
//  AnimeSensei
//
//  Created by Marcos Vinicius Alencar de Souza Okamoto on 30/07/26.
//

import Foundation

struct RecommendedAnime: Decodable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let episodes: Int?
    let genres: [String]
    let averageScore: Int?
    let coverImage: String?
    let recommendationScore: Int
    let reason: String
}


extension RecommendedAnime {
    var anime: Anime {
        Anime(
            id: id,
            title: title,
            description: description,
            episodes: episodes,
            genres: genres,
            averageScore: averageScore,
            coverImage: coverImage
        )
    }
}
