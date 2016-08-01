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
    
    @IBOutlet weak var pokemonEvoLabel: UILabel!
    
    
    
    @IBAction func backBtn(sender: UIButton) {
        //pop our detail view and load main view again
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    var detailPokemon: Pokemon!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeNameLabel.text = detailPokemon.name
       
        
        let img = UIImage(named: "\(detailPokemon.pokedexID)")
        pokeImg.image = img
        self.pokemonCurrEvoImg.image = img
        
        
        
        detailPokemon.downloadPokemonDetails {
            //This will be called after downloaded has been done
            //After downloaded, we can update the view
            //this function will be called after the closure has been called
            //the closure can help us call thefunction in the later time
            
            self.updateUI()

            
        }
        
    }
    
    func updateUI(){
        self.pokemonDef.text = self.detailPokemon.deffense
        self.pokemonAttack.text = self.detailPokemon.attack
        self.pokemonHeight.text = self.detailPokemon.height
        self.pokemonWeight.text = self.detailPokemon.weight
        self.pokeDescription.text = self.detailPokemon.description
        self.pokemonPokedexID.text = String(self.detailPokemon.pokedexID)
        self.pokemonType.text = self.detailPokemon.type
        
        if let nextEvolutionID = detailPokemon.evolutionID as? String{
            self.pokemonNextEvoImg.image = UIImage(named: detailPokemon.evolutionID)
            var str = "Next Evolution: \(self.detailPokemon.nextEvolutionName)"
            if self.detailPokemon.evolutionID != ""{
                str = str + " - LVL \(self.detailPokemon.evolutionID)"
            }
            self.pokemonEvoLabel.text = str

            self.pokemonNextEvoImg.hidden = false
        }else{
            self.pokemonEvoLabel.text = "NO EVOLUTION!!"
            self.pokemonNextEvoImg.hidden = true
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
}
