//
//  PokemonDetailViewModel.swift
//  ProDex
//
//  Created by Eduardo Gonzalez Melgoza on 23/11/23.
//

import Foundation

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonDetails: PokemonDetails?
    
    func fetchPokemonDetails(for id: Int) {
        PokemonService().fetchPokemonDetails(for: id) { result in
            switch result {
            case .success(let details):
                self.pokemonDetails = details
                
            case .failure(let error):
                // Handle the error here
                print("Error fetching Pokemon details: \(error)")
            }
        }
    }
}
