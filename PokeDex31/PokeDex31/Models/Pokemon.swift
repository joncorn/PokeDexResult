//
//  Pokemon.swift
//  PokeDex31
//
//  Created by Jon Corn on 1/21/20.
//  Copyright © 2020 jdcorn. All rights reserved.
//

import Foundation

// make sure it's decodable if it's coming from JSON
struct Pokemon: Decodable {
    let name: String
    let id: Int
    let baseXP: Int
    let sprites: Sprites
    
    enum CodingKeys: String, CodingKey {
        case baseXP = "base_experience"
        case name
        case id
        case sprites
    }
    
    struct Sprites: Decodable {
        let classic: URL
        
        enum CodingKeys: String, CodingKey {
            case classic = "front_default"
        }
    }
}
