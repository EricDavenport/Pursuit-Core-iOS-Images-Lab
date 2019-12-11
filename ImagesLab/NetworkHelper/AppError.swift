//
//  AppError.swift
//  ImagesLab
//
//  Created by Eric Davenport on 12/10/19.
//  Copyright © 2019 Eric Davenport. All rights reserved.
//

import Foundation

enum AppError: Error {
  case badURL(String) // associated value
  case noResponse
  case networkClientError(Error)
  case noData
  case decodingError(Error)
  case badStatusCode(Int) //  404/500
  case badMimetype(String) // image/jpg
}
