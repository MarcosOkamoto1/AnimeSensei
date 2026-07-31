//
//  ResultsView.swift
//  AnimeSensei
//
//  Created by Marcos Vinicius Alencar de Souza Okamoto on 28/07/26.
//

import SwiftUI

struct ResultsView: View {
    let searchText: String

    @State private var viewModel = ResultsViewModel()

    var body: some View {
        Group {
            if viewModel.isLoading {
                VStack(spacing: 16) {
                    ProgressView()

                    Text("Analisando suas preferências...")
                        .font(.headline)

                    Text("Buscando e selecionando os animes mais compatíveis.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()

            } else if let errorMessage = viewModel.errorMessage {
                ContentUnavailableView(
                    "Não foi possível buscar recomendações",
                    systemImage: "exclamationmark.triangle",
                    description: Text(errorMessage)
                )

            } else if viewModel.recommendations.isEmpty {
                ContentUnavailableView(
                    "Nenhuma recomendação encontrada",
                    systemImage: "magnifyingglass",
                    description: Text(
                        "Tente descrever suas preferências de outra forma."
                    )
                )

            } else {
                List(viewModel.recommendations) { recommendation in
                    NavigationLink {
                        AnimeDetailView(
                            anime: recommendation.anime
                        )
                    } label: {
                        VStack(alignment: .leading, spacing: 10) {
                            AnimeCardView(
                                anime: recommendation.anime
                            )

                            HStack {
                                Label(
                                    "\(recommendation.recommendationScore)%",
                                    systemImage: "sparkles"
                                )
                                .font(.caption)
                                .fontWeight(.semibold)

                                Spacer()
                            }

                            Text(recommendation.reason)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .lineLimit(3)
                        }
                        .padding(.vertical, 6)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Resultados")
        .task {
            await viewModel.search(searchText: searchText)
        }
    }
}
