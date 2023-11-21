//
//  PokemonDetailView.swift
//  ProDex
//
//  Created by Eduardo Gonzalez Melgoza on 16/11/23.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemonId: Int
    @StateObject private var pokemonService = PokemonService()
    
    // Properties to store fetched details
    @State private var pokemonName: String?
    @State private var pokemonHeight: Int?
    @State private var pokemonWeight: Int?

    var body: some View {
        ScrollView {
            VStack {
                if let image = pokemonService.pokemonImages[pokemonId - 1] {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ProgressView()
                        .frame(width: 100, height: 100)
                        .padding(5)
                        .onAppear {
                            // Load Pokémon image if it hasn't been loaded yet
                            if pokemonService.pokemonImages[pokemonId - 1] == nil {
                                pokemonService.fetchPokemonImage(id: pokemonId)
                            }
                        }
                }
                
                // Display fetched details
                if let name = pokemonName, let height = pokemonHeight, let weight = pokemonWeight {
                    Text("Name: \(name)")
                    Text("Height: \(height)")
                    Text("Weight: \(weight)")
                }
            }
        }.toolbar {
            ToolbarItem(placement: .principal) {
                if let image = pokemonService.pokemonImages[pokemonId - 1] {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .onAppear {
            // Call the function to fetch Pokemon details when the view appears
            pokemonService.fetchPokemonDetails(for: pokemonId) { result in
                switch result {
                    case .success(let pokemonDetails):
                        // Extract details and update state
                        pokemonName = pokemonDetails.name
                        pokemonHeight = pokemonDetails.height
                        pokemonWeight = pokemonDetails.weight

                    case .failure(let error):
                        // Handle the error here
                        print("Error fetching Pokemon details: \(error)")
                }
            }
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemonId: 9) // Provide a valid Pokemon ID for the preview
    }
}
