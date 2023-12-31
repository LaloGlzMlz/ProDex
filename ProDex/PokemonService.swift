import Foundation
import Observation
import SwiftUI
import Combine

class PokemonService: ObservableObject {
    
    @Published var pokemonList: [PokemonEntry] = []
    @Published var pokemonImages: [UIImage?] = Array(repeating: nil, count: 649)
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchPokemonImage(id: Int) {
        
        /*guard let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png") else {
            return
        }*/
        guard let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png") else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .compactMap { UIImage(data: $0) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.pokemonImages[id - 1] = image
            }
            .store(in: &cancellables)
    }
    
    func fetchPokemonDetails(for id: Int, completion: @escaping (Result<PokemonDetails, Error>) -> Void) {
        let apiUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!
        URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "Data is nil", code: 0, userInfo: nil)))
                return
            }

            do {
                // Use JSONDecoder to decode the data into the PokemonDetails model
                let decoder = JSONDecoder()
                let pokemonDetails = try decoder.decode(PokemonDetails.self, from: data)
                completion(.success(pokemonDetails))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
