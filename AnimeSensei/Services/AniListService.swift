//
//  AniListService.swift
//  AnimeSensei
//
//  Created by Marcos Vinicius Alencar de Souza Okamoto on 29/07/26.
//

import Foundation

final class AniListService{
    
    func fetchAnimes() async throws -> [Anime]{
        let query = """
        query {
            Page(page: 1, perPage: 10) {
                media(type: ANIME, sort: POPULARITY_DESC) {
                    id
                    title {
                        romaji
                    }
                    description
                    episodes
                    genres
                    averageScore
                    coverImage {
                        large
                    }
                }
            }
        }
        """
        struct GraphQLRequest: Encodable{
            let query: String
        }
        
        let requestBody = GraphQLRequest(query: query)
        guard let url = URL(string: "https://graphql.anilist.co") else{
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        request.httpBody = try JSONEncoder().encode(requestBody)
        
        let (data,response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard(200...299).contains(httpResponse.statusCode) else{
            throw URLError(.badServerResponse)
        }
        
        let decodedResponse = try JSONDecoder().decode(
            AniListResponse.self,
            from: data
        )

        let animes = decodedResponse.data.Page.media.map { apiAnime in
            Anime(
                id: apiAnime.id,
                title: apiAnime.title.romaji,
                description: apiAnime.description,
                episodes: apiAnime.episodes,
                genres: apiAnime.genres,
                averageScore: apiAnime.averageScore,
                coverImage: apiAnime.coverImage?.large
            )
        }
        return animes
    }
}

struct AniListResponse: Decodable {
    let data: AniListData
}

struct AniListData: Decodable {
    let Page: AniListPage
}

struct AniListPage: Decodable {
    let media: [AniListAnime]
}

struct AniListAnime: Decodable {
    let id: Int
    let title: AniListTitle
    let description: String?
    let episodes: Int?
    let genres: [String]
    let averageScore: Int?
    let coverImage: AniListCoverImage?
}

struct AniListTitle: Decodable {
    let romaji: String
}

struct AniListCoverImage: Decodable {
    let large: String?
}

