//
//  Pokemon.swift
//  PokietMonDect
//
//  Created by 辛忠翰 on 2016/7/26.
//  Copyright © 2016年 Keynote. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _attack: String!
    private var _def: String!
    private var _height: String!
    private var _weight: String!
    private var _nextEvolutionText: String!
    
    var name: String{
        return _name
    }
    
    var pokedexID: Int{
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int){
        self._name = name
        self._pokedexID = pokedexID
    }
    
    
}