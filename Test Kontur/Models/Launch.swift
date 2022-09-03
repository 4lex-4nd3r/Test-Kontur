//
//  Launch.swift
//  Test Kontur
//
//  Created by Александр on 29.08.2022.
//

import Foundation

struct Launch: Codable {
   
   let rocket: Rocket
   let success: Bool?
   let name: String
   let dateUTC: Date

   enum CodingKeys: String, CodingKey {
      case rocket
      case success
      case name
      case dateUTC = "date_utc"
   }
}

enum Rocket: String, Codable {
   case the5E9D0D95Eda69955F709D1Eb = "5e9d0d95eda69955f709d1eb"
   case the5E9D0D95Eda69973A809D1Ec = "5e9d0d95eda69973a809d1ec"
   case the5E9D0D95Eda69974Db09D1Ed = "5e9d0d95eda69974db09d1ed"
}
