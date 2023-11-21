//
//  ContentView.swift
//  ProDex
//
//  Created by Eduardo Gonzalez Melgoza on 14/11/23.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var pokemonService = PokemonService()
    
    var body: some View {
        let columnLayout = Array(repeating: GridItem(), count: 6)
        
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columnLayout) {
                    ForEach(1..<152) { id in
                        NavigationLink(destination: PokemonDetailView(pokemonId: id)) {
                            if let image = pokemonService.pokemonImages[id - 1] {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(1.0, contentMode: ContentMode.fit)
                            } else {
                                ProgressView()
                                    .frame(width: 100, height: 100)
                                    .padding(5)
                                    .onAppear {
                                        // Load Pokémon image only if it hasn't been loaded yet
                                        if pokemonService.pokemonImages[id - 1] == nil {
                                            pokemonService.fetchPokemonImage(id: id)
                                        }
                                    }
                            }
                        }
                    }
                }
                .navigationTitle("Pokédex")
                .padding()
            }
            .onAppear {
                // Load all Pokémon images when the view appears
                for id in 1..<152 {
                    pokemonService.fetchPokemonImage(id: id)
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
