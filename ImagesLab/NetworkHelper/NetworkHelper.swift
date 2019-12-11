//
//  NetworkHelper.swift
//  ImagesLab
//
//  Created by Eric Davenport on 12/10/19.
//  Copyright © 2019 Eric Davenport. All rights reserved.
//

import Foundation


class NetworkHelper {
  static let shared = NetworkHelper()
  
  private var session: URLSession
  
  private init() {
    session = URLSession.init(configuration: .default)
  }
  
  func performDataTask(with request: URLRequest,
                       completion: @escaping (Result<Data, AppError>) -> ()) {
    
//    guard let url = URL(url: request) else {
//      completion(.failure(.badURL(request)))
//      return
//    }
    
    let dataTask = session.dataTask(with: request) { (data, response, error) in
      if let error = error {
        completion(.failure(.networkClientError(error)))
      }
    
      guard let urlResponse = response as? HTTPURLResponse else {
        completion(.failure(.noResponse))
        return
      }
      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      
      switch urlResponse.statusCode {
      case 200...299: break
      default:
        completion(.failure(.badStatusCode(urlResponse.statusCode)))
        return
      }
      
      completion(.success(data))
      
    }
    dataTask.resume()
    
    
  }
  
}
