//
//  AnimeMockData.swift
//  AnimeSensei
//
//  Created by Marcos Vinicius Alencar de Souza Okamoto on 28/07/26.
//

import Foundation

enum AnimeMockData {
    static let animes = [
        Anime(
            id: 1,
            title: "Frieren",
            description: "Uma elfa reflete sobre o tempo e suas relações.",
            episodes: 28,
            genres: ["Fantasia", "Aventura"],
            averageScore: 90,
            coverImage: "https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx154587-n1fmjRv4JQUd.jpg"
        ),
        Anime(
            id: 2,
            title: "Violet Evergarden",
            description: "Uma jovem tenta entender o significado do amor.",
            episodes: 13,
            genres: ["Drama", "Fantasia"],
            averageScore: 88,
            coverImage: nil
        )
    ]
}
