//
//  AnimePreferences.swift
//  AnimeSensei
//
//  Created by Marcos Vinicius Alencar de Souza Okamoto on 30/07/26.
//

import Foundation

struct AnimePreferences: Decodable {
    let genres: [String]
    let excludedGenres: [String]
    let tags: [String]
    let excludedTags: [String]
    let mood: [String]
    let maxEpisodes: Int?
    let searchTerms: [String]
}
