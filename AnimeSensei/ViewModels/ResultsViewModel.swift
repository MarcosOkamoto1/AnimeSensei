//
//  ResultsViewModel.swift
//  AnimeSensei
//
//  Created by Marcos Vinicius Alencar de Souza Okamoto on 30/07/26.
//

import Foundation
import Observation

@Observable
@MainActor final class ResultsViewModel {
    var animes: [Anime] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let service = AniListService()
    
    func search(searchText:String) async {
    
        isLoading = true
        errorMessage = nil
        
        defer{
            isLoading = false
        }
        
        do{
            animes = try await service.fetchAnimes(searchText: searchText)
        }
        catch{
            errorMessage = error.localizedDescription
            
        }
        
        
    }
}
