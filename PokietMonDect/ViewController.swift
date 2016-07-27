//
//  ViewController.swift
//  PokietMonDect
//
//  Created by 辛忠翰 on 2016/7/25.
//  Copyright © 2016年 Keynote. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,
    UISearchBarDelegate
{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var pokemon = [Pokemon]()
    //it equles to pokemon arr, but just use for searching bar
    var filterPokemon = [Pokemon]()
    //if we r in the search mode, it means we need to use filterPokemon this array
    var inSearchMode: Bool = false
    
    
    var musicPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        //make keyboard's return to done
        searchBar.returnKeyType = UIReturnKeyType.Done
        self.parsePokeMonCSV()
        self.initAudio()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }

    //MARK: CSV parsing
    func parsePokeMonCSV() {
        //first: grabing the path of pokemon.csv
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        //second: to throw error
        do{
            //if sucess
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows{
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexID: pokeID)
                pokemon.append(poke)
            }
            print(self.pokemon)

            
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    
    //MARK: CollectionView
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            
            var poke: Pokemon!
            if inSearchMode{
                poke = filterPokemon[indexPath.row]
            }else{
                poke = pokemon[indexPath.row]

            }
            
            cell.configureCell(poke)
            
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let poke: Pokemon!
        
        
        if inSearchMode {
            poke = filterPokemon[indexPath.row]
        }else{
            poke = pokemon[indexPath.row]
        }
    
        //send poke to PokemonDetailVC
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
        
        
        
        
        
        
        
        
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode{
            return filterPokemon.count
        }
        
        return pokemon.count
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let padding:CGFloat = 10
        let collectionviewSize = self.collectionView.bounds.width
        let columnNum = 3
        let itemWidth: CGFloat = (collectionviewSize - padding * CGFloat(columnNum - 1)) / CGFloat(columnNum)
        
        return CGSizeMake(itemWidth, itemWidth)
    }
    
    
    //控制cell Y-padding之間的距離
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        
        return 10
    
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 10
    }
    
    //MARK: AVAudioPlayer
    
    func initAudio() {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path!)!)
            
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError{
            print(err.description)
        }
        
    }

    @IBAction func musicBtnPressed(sender: UIButton) {
        if musicPlayer.playing{
            musicPlayer.stop()
            sender.alpha = 0.2
        }else{
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    //MARK: SearchBar
    
    //when keyboard上的search 按鈕被按下後
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            inSearchMode = false
            
            //when finishing editing, we can force view to end editing
            //and make coo=llectionView reloadData
            //ex: delete all the text in searchbar
            //view.endEditing(true) can hide keyboard
            view.endEditing(true)
            collectionView.reloadData()
        }else{
            inSearchMode = true
            //將searchbar中的輸入的文字先轉成小寫，以利於後面的比對
            let lower = searchBar.text?.lowercaseString
            //$0 means every single object in pokemon arr, it can grab one pokemon object,poke
            //and grab poke.name to filter withe the word type in search bar
            //ex: $0 可以看成 var poke = pokemon[23]這個object
            //rangeOfString會去比對相符合的字串，最後在回傳到filterPokemon
            //filterPokemon = pokemon.filter({ $0.name .rangeOfString(lower!) != nil})
            //也可用這種方式打～～
            filterPokemon = pokemon.filter({ (poke) -> Bool in
                poke.name.rangeOfString(lower!) != nil
            })
            //everytime call reloadData in tableView, it will refresh whole list and grab every thing from ur datasource again
            collectionView.reloadData()

        }
        
        
    }
    
    
    //MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailVC = segue.destinationViewController as? PokemonDetailVC {
                if let poke = sender as? Pokemon{
                    detailVC.detailPokemon = poke                }
            }
        }
    }
}

