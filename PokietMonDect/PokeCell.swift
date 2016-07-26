//
//  PokeCell.swift
//  PokietMonDect
//
//  Created by 辛忠翰 on 2016/7/26.
//  Copyright © 2016年 Keynote. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokeMon: Pokemon) {
        self.pokemon = pokeMon
        
        //make pokemon's name be capital
        self.nameLabel.text = pokemon.name.capitalizedString
        self.pokeImg.image = UIImage(named: "\(self.pokemon.pokedexID)")
        
        
    }
}
