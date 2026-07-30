import SwiftUI

struct ResultsView: View {
    let searchText: String

    @State private var animes: [Anime] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    private let service = AniListService()

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading animes...")
            } else if let errorMessage {
                Text(errorMessage)
            } else {
                List(animes) { anime in
                    NavigationLink {
                        AnimeDetailView(anime: anime)
                    } label: {
                        AnimeCardView(anime: anime)
                    }
                }
            }
        }
        .navigationTitle("Resultados")
        .task {
            isLoading = true

            do {
                animes = try await service.fetchAnimes(
                    searchText: searchText
                )
            } catch {
                errorMessage = error.localizedDescription
            }

            isLoading = false
        }
    }
}
