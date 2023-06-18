//
//  Character.swift
//  RickandMortyIOS5
//
//  Created by Colton Brenneman on 6/16/23.
//

import Foundation

class Character {

    let name: String
    let id: Int
    let image: String

    init(name: String, id: Int, image: String) {
        self.name = name
        self.id = id
        self.image = image
    }
} //End of class

// MARK: - Extension
extension Character {
    convenience init?(topLevelDictionary: [String : Any]) {
        guard let resultsArray = topLevelDictionary["results"] as? [[String : Any]],
              let characterDict = resultsArray.first,
              let characterID = characterDict["id"] as? Int,
              let characterName = characterDict["name"] as? String,
        let characterImage = characterDict["image"] as? String else { return nil }
        
        self.init(name: characterName, id: characterID, image: characterImage)
    }
} //End of extension

