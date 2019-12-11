//
//  PokemonViewController.swift
//  ImagesLab
//
//  Created by Eric Davenport on 12/11/19.
//  Copyright © 2019 Eric Davenport. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var pokeDeck = [Pokemon]() {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
    tableView.dataSource = self
  }
  
  
  func loadData() {
    PokemonAPI.getCards { (result) in
      switch result {
      case .failure(let appError):
        print("appError: \(appError)")
      case .success(let pokemon):
        self.pokeDeck = pokemon
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let pokemonDetailVC = segue.destination as? DetailVC,
      let indexPath = tableView.indexPathForSelectedRow else {
        fatalError("failed to segue properly")
    }
    
    pokemonDetailVC.pokemon = pokeDeck[indexPath.row]
    
    

  }
  
}

extension PokemonViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
    
    // need to question this
    // can perpareForReuse() be used ooutsie of of customcell file
    cell.prepareForReuse()   // what does putting this in cellForRow do
    
    
    let pokemon = pokeDeck[indexPath.row]
    
    let url = URL(string: pokemon.imageUrlHiRes ?? "")!
    let request = URLRequest(url: url)
    
    NetworkHelper.shared.performDataTask(with: request) { [weak cell] (result) in
      switch result {
      case .failure(let appError):
        print("\(appError)")
      case .success(let image):
        DispatchQueue.main.async {
          cell?.imageView?.image = UIImage(data: image)
          cell?.textLabel?.text = pokemon.name
        }
      }
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pokeDeck.count
  }
}

