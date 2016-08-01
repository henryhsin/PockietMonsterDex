//
//  Constant.swift
//  PokietMonDect
//
//  Created by 辛忠翰 on 2016/7/28.
//  Copyright © 2016年 Keynote. All rights reserved.
//

import Foundation

let URL_BASE = "https://pokeapi.co"
let URL_POKEMON = "/api/v2/pokemon/"
let URL_POKEDEX = "/api/v2/pokedex/"
let URL_POKESPECIES = "/api/v2/pokemon-species/"

// it seems didn't give cmopleted evolution information
let URL_POKEEVOLUTION_V2 = "/api/v2/evolution-chain/"
// so we use v1's api to get the evoluted information
let URL_BASE_NO_SECURITY = "http://pokeapi.co"
let URL_POKEEVOLUTION_V1 = "/api/v1/pokemon/"



//create a simple closure
typealias DownloadComplete = () -> ()

//the attack and dfense is in stats[4] and states[3]
let ATTACK = 4
let DEFENSE = 3

//the pokemon description is as same as the flavor_text, and it is in pokemon-species's flavor_text_entries[1] 
let DESCRIPTION = 1

//evolution_to in v1 api/pokemon/index/evolution[0]["to"]
let EVOLUTION_TO = 0



