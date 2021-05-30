//
//  PlayerResponse.swift
//  Football App
//
//  Created by BarisOdabasi on 27.05.2021.
//

import Foundation

class PlayerResponse: Codable {
    var api: PlayerData
    
}

struct PlayerData: Codable {
    let results: Int
    let players: [Player]
}



class Player: Codable {
    var playerId: Int? = 0
    var playerName: String? = ""
    var firstName: String? = ""
    var position: String? = ""
    var age: Int? = 0
    var birthDate: String? = ""
    var birthCountry: String? = ""
    var nationality: String? = ""
    var height: String? = ""
    var weight: String? = ""
    var teamName: String? = ""
    
    
    enum CodingKeys: String, CodingKey {
        case playerId = "player_id"
        case playerName = "player_name"
        case firstName = "firstname"
        case position = "position"
        case age = "age"
        case birthDate = "birth_date"
        case birthCountry = "birth_country"
        case nationality = "nationality"
        case height = "height"
        case weight = "weight"
        case teamName = "team_name"
        
    }
    
}
