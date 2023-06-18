//
//  NetworkController.swift
//  RickandMortyIOS5
//
//  Created by Colton Brenneman on 6/17/23.
//

import Foundation

class NetworkController {
    
    func fetchCharacter(with searchTerm: String, completion: @escaping([Character]?) -> Void) {
        guard let baseURL = URL(string: "https://rickandmortyapi.com/api") else { completion(nil) ; return }
        let finalURL = baseURL.appending(path: "character")
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error {
                print("AH fuck dude there's an error", error.localizedDescription)
                completion(nil)
            } //End of error
            guard let data = data else { completion(nil) ; return }
            var characters: [Character] = []
            do {
                if let topLevelDictionary = try JSONSerialization.jsonObject(with: data) as? [String : Any] {
                    if let resultsArray = topLevelDictionary["results"] as? [[String : Any]] {
                        for resultDict in resultsArray {
                            guard let character = Character(topLevelDictionary: resultDict) else { completion(nil) ; return }
                            characters.append(character)
                        }
                    }
                }
            } catch {
                print("OH SHIT THERE'S AN ERROR WITH THE JSON SINCE IT CAN'T BE READ", error.localizedDescription)
                completion(nil)
                return
            }
        }.resume() //End of dataTask
    } //End of fetchCharacter
} //End of class
