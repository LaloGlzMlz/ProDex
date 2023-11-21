//
//  PokemonModels.swift
//  ProDex
//
//  Created by Eduardo Gonzalez Melgoza on 17/11/23.
//

import Foundation
import SwiftUI

// Define the structure to represent the Pokemon list
struct PokemonList: Decodable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [PokemonEntry]
}

// Define the structure to represent a Pokemon entry
struct PokemonEntry: Decodable {
    let name: String
    let url: URL
}

// THIS IS THE REAL MODEL
struct PokemonDetails: Decodable {
    let abilities: [AbilityDetails]
    let forms: [PokemonForm]
    let height: Int
    let id: Int
    let name: String
    let species: PokemonSpecies
    let sprites: PokemonSprites
    let stats: [StatValues]
    let types: [TypeDetails]
    let weight: Int
}

struct AbilityDetails: Decodable {
    let ability: Ability
    let isHidden: Bool
    let slot: Int

    private enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct Ability: Decodable {
    let name: String
    let url: String
}

struct PokemonForm: Decodable {
    let name: String
    let url: String
}

struct PokemonSpecies: Decodable {
    let name: String
    let url: String
}

struct PokemonSprites: Decodable {
    let frontDefault: URL?
    let frontShiny: URL?
    let other: OtherSprites
}

struct OtherSprites: Decodable {
    let officialArtwork: OfficialArtworkSprites
}

struct OfficialArtworkSprites: Decodable {
    let frontDefault: URL?
    let frontShiny: URL?
}

struct StatValues: Decodable {
    let baseStat: Int
    let effort: Int
    let stat: Stat

    private enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

struct Stat: Decodable {
    let name: String
    let url: String
}

struct TypeDetails: Decodable {
    let slot: Int
    let pokemonType: PokemonTypeAlias

    private enum CodingKeys: String, CodingKey {
        case slot
        case pokemonType = "type"
    }
}

struct PokemonTypeAlias: Decodable {
    let name: String
    let url: String
}
