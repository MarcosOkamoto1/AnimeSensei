import Foundation
import Observation

@Observable
@MainActor
final class ResultsViewModel {
    var recommendations: [RecommendedAnime] = []
    var isLoading = false
    var errorMessage: String?

    private let service = RecommendationService()

    func search(searchText: String) async {
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
        }
    }
}
