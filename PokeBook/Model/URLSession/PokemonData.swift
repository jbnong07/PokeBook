//
//  PokemonData.swift
//  PokeBook
//
//  Created by 박진홍 on 12/10/24.
//

import Foundation

struct PokemonData: Codable {
    let sprites: Sprites
}

struct Sprites: Codable {
    let backDefault: String?
    
    enum CodingKeys: String, CodingKey {//코딩 컨벤션 통일을 위해 enum으로 정의
        case backDefault = "back_default"
    }
}
