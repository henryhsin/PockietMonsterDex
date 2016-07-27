//
//  PokemonDetailVC.swift
//  PokietMonDect
//
//  Created by 辛忠翰 on 2016/7/27.
//  Copyright © 2016年 Keynote. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var detailPokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeLabel(detailPokemon.name)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeLabel(text: String) {
        var label: UILabel!
        label = UILabel()
        label.frame = CGRectMake(150, 150, 50, 50)
        label.text = text
        self.view.addSubview(label)
    }
}
