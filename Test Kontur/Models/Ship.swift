//
//  Ship.swift
//  Test Kontur
//
//  Created by Александр on 30.08.2022.
//

import Foundation


struct Ship: Codable {
   
   let name: String
   
   let height: Diameter
   let diameter: Diameter
   let mass: Mass
   let payloadWeights: [PayloadWeight]
   
   let firstFlight: Date
   let country: String
   let costPerLaunch: Int
   
   let firstStage: FirstStage
   let secondStage: SecondStage
   
   let id: String
   
   enum CodingKeys: String, CodingKey  {
      case name
      
      case height
      case diameter
      case mass
      case payloadWeights = "payload_weights"
      
      case firstFlight = "first_flight"
      case country
      case costPerLaunch = "cost_per_launch"
      
      case firstStage = "first_stage"
      case secondStage = "second_stage"
      
      case id
   }
}

// MARK: - Diameter

struct Diameter: Codable {
   let meters: Double?
   let feet: Double?
}
// MARK: - Mass

struct Mass: Codable {
   let kg: Int
   let lb: Int
}

// MARK: - PayloadWeight

struct PayloadWeight: Codable {
   let kg: Int
   let lb: Int
}

// MARK: - FirstStage
struct FirstStage: Codable {

   let engines: Int
   let fuelAmountTons: Double
   let burnTimeSEC: Int?
   
   enum CodingKeys: String, CodingKey {
      case engines
      case fuelAmountTons = "fuel_amount_tons"
      case burnTimeSEC = "burn_time_sec"
   }
}

// MARK: - SecondStage
struct SecondStage: Codable {
  
  
   let engines: Int
   let fuelAmountTons: Double
   let burnTimeSEC: Int?
   
   enum CodingKeys: String, CodingKey {
      case engines
      case fuelAmountTons = "fuel_amount_tons"
      case burnTimeSEC = "burn_time_sec"
   }
}



