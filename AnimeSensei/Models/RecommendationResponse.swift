//
//  RecommendationResponse.swift
//  AnimeSensei
//
//  Created by Marcos Vinicius Alencar de Souza Okamoto on 30/07/26.
//

import Foundation

struct RecommendationResponse: Decodable {
    let preferences: AnimePreferences
    let recommendations: [RecommendedAnime]
}
