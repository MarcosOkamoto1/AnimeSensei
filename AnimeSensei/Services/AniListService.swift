//
//  AniListService.swift
//  AnimeSensei
//
//  Created by Marcos Vinicius Alencar de Souza Okamoto on 29/07/26.
//

import Foundation

final class AniListService {

    func fetchAnimes(searchText: String) async throws -> [Anime] {
        let query = """
        query ($search: String!) {
            Page(page: 1, perPage: 10) {
                media(
                    search: $search,
                    type: ANIME,
                    sort: POPULARITY_DESC
                ) {
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

        let requestBody = GraphQLRequest(
            query: query,
            variables: GraphQLVariables(search: searchText)
        )

        guard let url = URL(string: "https://graphql.anilist.co") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        request.httpBody = try JSONEncoder().encode(requestBody)

        let (data, response) = try await URLSession.shared.data(
            for: request
        )

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decodedResponse = try JSONDecoder().decode(
            AniListResponse.self,
            from: data
        )

        let animes = decodedResponse.data.page.media.map { apiAnime in
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

// MARK: - Request models

private struct GraphQLVariables: Encodable {
    let search: String
}

private struct GraphQLRequest: Encodable {
    let query: String
    let variables: GraphQLVariables
}

// MARK: - Response models

private struct AniListResponse: Decodable {
    let data: AniListData
}

private struct AniListData: Decodable {
    let page: AniListPage

    enum CodingKeys: String, CodingKey {
        case page = "Page"
    }
}

private struct AniListPage: Decodable {
    let media: [AniListAnime]
}

private struct AniListAnime: Decodable {
    let id: Int
    let title: AniListTitle
    let description: String?
    let episodes: Int?
    let genres: [String]
    let averageScore: Int?
    let coverImage: AniListCoverImage?
}

private struct AniListTitle: Decodable {
    let romaji: String
}

private struct AniListCoverImage: Decodable {
    let large: String?
}
