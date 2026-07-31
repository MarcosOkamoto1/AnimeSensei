//
//  ResultsViewModel.swift
//  AnimeSensei
//
//  Created by Marcos Vinicius Alencar de Souza Okamoto on 30/07/26.
//


import Foundation
import Observation

@Observable
@MainActor
final class ResultsViewModel {
    var recommendations: [RecommendedAnime] = []
    var isLoading = false
    var errorMessage: String?

    private var hasLoaded = false
    private let service = RecommendationService()

    func search(searchText: String) async {
        guard !hasLoaded else {
            return
        }

        hasLoaded = true
        isLoading = true
        errorMessage = nil
        recommendations = []

        defer {
            isLoading = false
        }

        do {
            let response = try await service.fetchRecommendations(
                prompt: searchText
            )

            recommendations = response.recommendations
        } catch {
            errorMessage = error.localizedDescription
            hasLoaded = false
        }
    }
}
