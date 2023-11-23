//
//  TypeColorDefinitions.swift
//  ProDex
//
//  Created by Eduardo Gonzalez Melgoza on 22/11/23.
//

import Foundation
import SwiftUI

struct PokemonColorConfiguration {
    let normalColor: Color
    let fightingColor: Color
    let flyingColor: Color
    let poisonColor: Color
    let groundColor: Color
    let rockColor: Color
    let bugColor: Color
    let ghostColor: Color
    let steelColor: Color
    let fireColor: Color
    let waterColor: Color
    let grassColor: Color
    let electricColor: Color
    let psychicColor: Color
    let iceColor: Color
    let dragonColor: Color
    let darkColor: Color
    let fairyColor: Color
}

struct PokemonColorUtility {
    
    enum PokemonType: String {
        case normal, fighting, flying,
             poison, ground, rock, bug,
             ghost, steel, fire, water,
             grass, electric, psychic,
             ice, dragon, dark, fairy // Add more types as needed
        
        // Default case
        case unknown
    }
    
    static func getColorForType(_ type: PokemonTypeAlias, config: PokemonColorConfiguration) -> Color {
        switch type.name {
            case "normal":
                return config.normalColor
            case "fighting":
                return config.fightingColor
            case "flying":
                return config.flyingColor
            case "poison":
                return config.poisonColor
            case "ground":
                return config.groundColor
            case "rock":
                return config.rockColor
            case "bug":
                return config.bugColor
            case "ghost":
                return config.ghostColor
            case "steel":
                return config.steelColor
            case "fire":
                return config.fireColor
            case "water":
                return config.waterColor
            case "grass":
                return config.grassColor
            case "electric":
                return config.electricColor
            case "psychic":
                return config.psychicColor
            case "ice":
                return config.iceColor
            case "dragon":
                return config.dragonColor
            case "dark":
                return config.darkColor
            case "fairy":
                return config.fairyColor
            // Add more cases as needed
            default:
                return config.normalColor
        }
    }

    static func getColorFromAsset(_ assetName: String) -> Color {
        guard let uiColor = UIColor(named: assetName) else {
            return .gray // Default color if the asset is not found
        }
        return Color(uiColor)
    }
}
