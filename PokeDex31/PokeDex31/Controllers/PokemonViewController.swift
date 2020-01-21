//
//  PokemonViewController.swift
//  PokeDex31
//
//  Created by Jon Corn on 1/21/20.
//  Copyright © 2020 jdcorn. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var pokeSearchbar: UISearchBar!
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var baseXPLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearchbar.delegate = self
    }
    
    // MARK: - Private Methods
    private func fetchSpriteAndUpdateViews(for pokemon: Pokemon) {
        PokemonController.fetchSprite(for: pokemon) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let sprite):
                    self.nameLabel.text = pokemon.name
                    self.baseXPLabel.text = "\(pokemon.baseXP)"
                    self.idLabel.text = "\(pokemon.id)"
                    self.spriteImageView.image = sprite
                    
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}

// MARK: - UISearchBar Delegate
extension PokemonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        PokemonController.fetchPokemon(for: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.fetchSpriteAndUpdateViews(for: pokemon)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
