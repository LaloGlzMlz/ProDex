import SwiftUI

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

struct PokemonDetailView: View {
    let pokemonId: Int
    @ObservedObject private var viewModel = PokemonDetailViewModel()
    @ObservedObject private var pokemonService = PokemonService()
    
    var body: some View {
        ScrollView {
            VStack {
                
                // Official Artwork
                if let officialArtworkURL = viewModel.pokemonDetails?.sprites.other.officialArtwork.frontDefault {
                    AsyncImage(url: officialArtworkURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: 280) // Adjust the frame size as needed
                        case .failure:
                            Image(systemName: "pkball") // Placeholder image for failure
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: 280) // Adjust the frame size as needed
                        }
                    }
                } // Official Artwork ends
                
                // Display fetched details
                if let details = viewModel.pokemonDetails {
                    Text("ID: \(pokemonId)")
                    Text("Name: \(details.name)")
                    Text("Height: \(details.height)")
                    Text("Weight: \(details.weight)")
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                // frontDefault sprite
                if let officialArtworkURL = viewModel.pokemonDetails?.sprites.frontDefault {
                    AsyncImage(url: officialArtworkURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                        case .failure:
                            Image(systemName: "pkball") // Placeholder image for failure
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: 280) // Adjust the frame size as needed
                        }
                    }
                }
            }
        }
        .onAppear {
            // Call the function to fetch Pokemon details when the view appears
            viewModel.fetchPokemonDetails(for: pokemonId)
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemonId: 9) // Provide a valid Pokemon ID for the preview
    }
}
