//
//  RecommendationService.swift
//  AnimeSensei
//
//  Created by Marcos Vinicius Alencar de Souza Okamoto on 30/07/26.
//

import Foundation

final class RecommendationService {
    func fetchRecommendations(prompt: String) async throws -> RecommendationResponse {
        guard let url = URL(
            string: "http://localhost:3000/recommendations"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        let requestBody = RecommendationRequest(
            prompt: prompt
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

        return try JSONDecoder().decode(
            RecommendationResponse.self,
            from: data
        )
    }
}

private struct RecommendationRequest: Encodable {
    let prompt: String
}
