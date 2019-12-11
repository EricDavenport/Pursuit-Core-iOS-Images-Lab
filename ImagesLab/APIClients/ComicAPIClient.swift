//
//  ComicAPIClient.swift
//  ImagesLab
//
//  Created by Eric Davenport on 12/10/19.
//  Copyright © 2019 Eric Davenport. All rights reserved.
//

import Foundation

struct ComicAPI {

static func getComics(for comicNum: Int,
                      completion: @escaping (Result<ComicStrips, AppError>) -> ()) {
  
  let comicURL = "https://xkcd.com/\(comicNum)/info.0.json"
  
  guard let url = URL(string: comicURL) else {
    completion(.failure(.badURL(comicURL)))
    return
  }
  
  let request = URLRequest(url: url)
  
  NetworkHelper.shared.performDataTask(with: request) { (result) in
   
    switch result {
    case .failure(let appError):
      completion(.failure(.networkClientError(appError)))
    case .success(let data):
      do {
        let results = try JSONDecoder().decode(ComicStrips.self, from: data)
        
        completion(.success(results))
        
      } catch {
        completion(.failure(.decodingError(error)))
        
      }
    }
  }
}


}
