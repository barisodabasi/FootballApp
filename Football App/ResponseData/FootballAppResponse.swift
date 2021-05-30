//
//  FootballAppResponse.swift
//  Football App
//
//  Created by BarisOdabasi on 22.05.2021.
//

import Foundation

class FootballAppResponse: Codable {
    var api: TeamResponse
    
}

struct TeamResponse: Codable {
    let results: Int
    let teams: [Teams]
}

class Teams: Codable {
    var teamId: Int = 0
    var name: String? = ""
    var logo: URL?
    var code: String? = ""
    var stadiumName: String? = ""
    var stadiumCapacity: Int? = 0
    var founded: Int? = 0
    
    enum CodingKeys: String, CodingKey {
        case teamId = "team_id"
        case name = "name"
        case logo = "logo"
        case code = "code"
        case stadiumName = "venue_name"
        case stadiumCapacity = "venue_capacity"
        case founded = "founded"
        
    }
}





