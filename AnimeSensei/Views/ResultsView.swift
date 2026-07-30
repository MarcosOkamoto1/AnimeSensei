import SwiftUI

struct ResultsView: View {
    let searchText: String
    
    @State private var viewModel = ResultsViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading animes...")
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            } else {
                List(viewModel.animes) { anime in
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
           await viewModel.search(searchText: searchText)
        }
    }
}
