//
//  PokemonAPI.swift
//  ImagesLab
//
//  Created by Eric Davenport on 12/11/19.
//  Copyright © 2019 Eric Davenport. All rights reserved.
//

import Foundation

struct PokemonAPI {
  
  static func getCards(completion: @escaping (Result <[Pokemon], AppError>) ->()) {
    
    let deckURL = "https://api.pokemontcg.io/v1/cards"
    var pokeDeck = [Pokemon]()
    
    guard let url = URL(string: deckURL) else {
      completion(.failure(.badURL(deckURL)))
      return
    }
  
  
  let request = URLRequest(url: url)
    
    NetworkHelper.shared.performDataTask(with: request) { (result) in
      
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success(let card):
        do {
          let cards = try JSONDecoder().decode(PokemonCards.self, from: card)
          pokeDeck = cards.cards
          completion(.success(pokeDeck))
          
        } catch {
          completion(.failure(.decodingError(error)))
          
        }
      }
    }
  
  }
}
