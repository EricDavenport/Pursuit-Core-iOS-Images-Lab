//
//  ComicModel.swift
//  ImagesLab
//
//  Created by Eric Davenport on 12/10/19.
//  Copyright © 2019 Eric Davenport. All rights reserved.
//

import Foundation

struct ComicStrips: Decodable {
  let month: String
  let num: Int
  let link: String
  let year: String
  let news: String
  let safe_title: String
  let transcript: String
  let alt: String
  let img: String
  let title: String
  let day: String
}

enum CodingKeys: String, CodingKey {
  case safeTitle = "safe_title"
}
