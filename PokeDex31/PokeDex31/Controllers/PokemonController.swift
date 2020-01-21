//
//  PokemonController.swift
//  PokeDex31
//
//  Created by Jon Corn on 1/21/20.
//  Copyright © 2020 jdcorn. All rights reserved.
//

import Foundation
import UIKit.UIImage

class PokemonController {
    
    // String Helpers
    fileprivate static let baseURL = URL(string: "https://pokeapi.co/api/v2")
    fileprivate static let pokemonPathComponent = "pokemon"
    
    // MARK: - Functions
    static func fetchPokemon(for searchTerm: String, completion: @escaping (Result<Pokemon, PokemonError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let pokemonURL = baseURL.appendingPathComponent(pokemonPathComponent)
        let finalURL = pokemonURL.appendingPathComponent(searchTerm.lowercased())
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchSprite(for pokemon: Pokemon, completion: @escaping (Result<UIImage, PokemonError>) -> Void) {
        let url = pokemon.sprites.classic
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            completion(.success(image))
            
        }.resume()

    }
}
