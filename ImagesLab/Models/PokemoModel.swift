//
//  PokemoModel.swift
//  ImagesLab
//
//  Created by Eric Davenport on 12/11/19.
//  Copyright © 2019 Eric Davenport. All rights reserved.
//

import Foundation

struct PokemonCards: Decodable {
  var cards: [Pokemon]
}
struct Pokemon: Decodable {
  var name: String?
  var type: String?
  var set: String?
  var weakness: Weakness?
  var imageUrlHiRes: String?
}

struct Weakness: Decodable {
  var type: String
  var value: String
}
