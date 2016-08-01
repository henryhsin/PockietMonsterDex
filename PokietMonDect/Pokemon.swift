//
//  Pokemon.swift
//  PokietMonDect
//
//  Created by 辛忠翰 on 2016/7/26.
//  Copyright © 2016年 Keynote. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    //MARK: property
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _attack: String!
    private var _def: String!
    private var _height: String!
    private var _weight: String!
    private var _nextEvolutionName: String!
    private var _evolutionLevel: String!
    private var _evolutionID: String!

    
    
    
    
    //MARK: URL
    private var _pokemonURL: String!
    private var _pokedexURL: String!
    private var _pokeSpciesURL: String!
    private var _pokeEvolutionV1URL: String!
    
    
    
    //MARK: request
    private var pokemonURLRequest: Request!
    private var pokeSpeciesURLRequest: Request!
    private var pokeEvolutionURLV1Request: Request!
    
    var name: String{
        return _name
    }
    
    var pokedexID: Int{
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int){
        self._name = name
        self._pokedexID = pokedexID
        
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexID)/"
        self._pokedexURL = "\(URL_BASE)\(URL_POKEDEX)\(self._pokedexID)/"
        self._pokeSpciesURL = "\(URL_BASE)\(URL_POKESPECIES)\(self._pokedexID)/"
        self._pokeEvolutionV1URL = "\(URL_BASE_NO_SECURITY)\(URL_POKEEVOLUTION_V1)\(self._pokedexID)/"
        
        
    }
    
    var attack: String{
        //it can promise that the program wont crash if unwrap the nil constance
        get{
            if _attack == nil{
                _attack = ""
            }
                return _attack
        }
    }
    
    var deffense: String{
        get{
            if _def == nil{
                _def = ""
            }
            return _def
        }
    }
    
    var height: String{
        get{
            if _height == nil{
                _height = ""
            }
            return _height
        }
    }
    
    var weight: String{
        get{
            if _weight == nil{
                _weight = ""
            }
            return _weight
        }
    }
    
    var description: String{
        get{
            if _description == nil{
                _description = ""
            }
            return _description
        }
    }
    
    var type: String{
        get{
            if _type == nil{
                _type = ""
            }
            return _type
        }
    }
    
    var nextEvolutionName: String{
        get{
            if _nextEvolutionName == nil{
                _nextEvolutionName = ""
            }
            return _nextEvolutionName
        }
    }
    
    var evolutionLevel: String{
        get{
            if _evolutionLevel == nil{
                _evolutionLevel = ""
            }
            return _evolutionLevel
        }
    }
    
    var evolutionID: String{
        get{
            if _evolutionID == nil{
                _evolutionID = ""
            }
            return _evolutionID
        }
    }
    
    
    func downloadPokemonDetails(completed: DownloadComplete){
        
        let pokemonURL = NSURL(string: _pokemonURL)
        pokemonURLRequest = Alamofire.request(.GET, pokemonURL!).responseJSON { (response) in
            let result = response.result
            
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                //attack, defense, special-defense, special-attack, hp in stats dictionary
                if let stats = dict["stats"] as? [Dictionary<String, AnyObject>]{
                    self._def = "\(stats[DEFENSE]["base_stat"]!)"
                    self._attack = "\(stats[ATTACK]["base_stat"]!)"
                    
                }
                
                
                //weight and height
                if let height = dict["height"] as? Int{
                    self._height = String(height)
                }
                
                if let weight = dict["weight"] as? Int{
                    self._weight = String(weight)
                }
                
                
                
                //type
                //the structure of "types" is <"types", [Dictionary<String, AnyObject>]>
                if let types = dict["types"] as?[Dictionary<String, AnyObject>] where types.count > 0{
                    //where types.count > 0確保所有pokemon都有types
                    
                    self._type = ""
                    for type in types{
                        let name = type["type"]!["name"] as! String
                        if self._type == ""{
                            self._type.appendContentsOf("\(name.capitalizedString)")
                        }else{
                            self._type.appendContentsOf("/ \(name.capitalizedString)")
                        }
                    }
                    
                }
            }
            completed()

            
        }
        
        let pokeSpeciesURL = NSURL(string: _pokeSpciesURL)
        pokeSpeciesURLRequest = Alamofire.request(.GET, pokeSpeciesURL!).responseJSON{ response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let flavortxt = dict["flavor_text_entries"] as? [Dictionary<String, AnyObject>]{
                    
                   self._description = flavortxt[DESCRIPTION]["flavor_text"] as! String
                    print(self._description)
                    print("")
                }
            }
            completed()

            
        }
        
        
        
        let pokeEvolutionV1URL = NSURL(string: _pokeEvolutionV1URL)
        pokeEvolutionURLV1Request = Alamofire.request(.GET, pokeEvolutionV1URL!).responseJSON{ response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let evolution = dict["evolutions"] as? [Dictionary<String, AnyObject>]{
                    
                    let secondEvolutionName = evolution[EVOLUTION_TO]["to"] as? String
                    self._nextEvolutionName = secondEvolutionName
                    
                    if secondEvolutionName?.rangeOfString("mega") == nil{
                        if let nextEvolutionUrl = evolution[EVOLUTION_TO]["resource_uri"] as? String{
                                var newStr = nextEvolutionUrl.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                            
                                newStr = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                        
                                self._evolutionID = newStr
                        }
                    }
                    
                    
                    let evolutionLevel = evolution[EVOLUTION_TO]["level"] as? String
                    self._evolutionLevel = evolutionLevel
                    
                }
                completed()

            }
            
            
        }
        
        
        
        /*
        let pokeEvolutionURL = NSURL(string: _pokeEvolutionURL)
        pokeEvolutionURLRequest = Alamofire.request(.GET, pokeEvolutionURL!).responseJSON{ response in
            
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let chain = dict["chain"] as? Dictionary<String, AnyObject>{
                    
                    if let evolves_to = chain["evolves_to"] as? [Dictionary<String, AnyObject>]{
                        print(evolves_to)
                        
                        print("QQ")
                        print(evolves_to[0]["species"]!["name"])
                          print("")
                    }
                    
                  
                    
                    //self._nextEvolutionText.append(<#T##newElement: Element##Element#>)
                }
            }
            
        }*/
        
        
        
        
    }
        
    
    
}