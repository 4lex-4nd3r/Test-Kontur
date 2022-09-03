//
//  ShipsManager.swift
//  Test Kontur
//
//  Created by Александр on 30.08.2022.
//

import Foundation

class ShipsManager {
   
   
   func requestShips(completion: @escaping (Result<[Ship], Error>) -> Void) {
      
      let stringURL = "https://api.spacexdata.com/v4/rockets"
      guard let url = URL(string: stringURL) else { return }
      URLSession.shared.dataTask(with: url) { data, response, error in
         DispatchQueue.main.async {
            if let error = error {
               completion(.failure(error))
            }
            guard let data = data else { return }
            do {
               let decoder = JSONDecoder()
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "yyyy-MM-dd"
               decoder.dateDecodingStrategy = .formatted(dateFormatter)
               let ships = try decoder.decode([Ship].self, from: data)
               completion(.success(ships))
               
            } catch let jsonError {
               completion(.failure(jsonError))
            }
         }
      }.resume()
   }
   
   func requestLaunches(completion: @escaping (Result<[Launch], Error>) -> Void) {
      let stringURL = "https://api.spacexdata.com/v4/launches/past"
      guard let url = URL(string: stringURL) else { return }
      URLSession.shared.dataTask(with: url) { data, response, error in
         DispatchQueue.main.async {
            if let error = error {
               completion(.failure(error))
            }
            guard let data = data else { return }
            do {
               let decoder = JSONDecoder()
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
               decoder.dateDecodingStrategy = .formatted(dateFormatter)
               let launches = try decoder.decode([Launch].self, from: data)
               completion(.success(launches))
               
            } catch let jsonError {
               completion(.failure(jsonError))
            }
         }
      }.resume()
   }
   
}
