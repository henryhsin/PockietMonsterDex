//
//  PokemonDetailVC.swift
//  PokietMonDect
//
//  Created by 辛忠翰 on 2016/7/27.
//  Copyright © 2016年 Keynote. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var pokeNameLabel: UILabel!
    
    
    @IBOutlet weak var pokeImg: UIImageView!
    
    @IBOutlet weak var pokeDescription: UILabel!
    
    @IBOutlet weak var pokemonType: UILabel!
    
    @IBOutlet weak var pokemonDef: UILabel!
    
    
    @IBOutlet weak var pokemonHeight: UILabel!
    
    
    @IBOutlet weak var pokemonPokedexID: UILabel!
    
    
    @IBOutlet weak var pokemonWeight: UILabel!
    
    
    @IBOutlet weak var pokemonAttack: UILabel!
    
    
    
    @IBOutlet weak var pokemonCurrEvoImg: UIImageView!
    
    @IBOutlet weak var pokemonNextEvoImg: UIImageView!
    
    @IBOutlet weak var evoLabel: UILabel!
    
    @IBAction func backBtn(sender: UIButton) {
        //pop our detail view and load main view again
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    var detailPokemon: Pokemon!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
}
