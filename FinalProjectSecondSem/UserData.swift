//
//  UserData.swift
//  FinalProjectSecondSem
//
//  Created by Sukhjeet Singh on 23/05/21.
//

import Foundation

class UserData{
    
    var name: String!
    var email: String!
    var password: String!
    var age: Int32!
    var game_score: Int64!
    
    
    init(name: String, email: String, password: String, age: Int32, game_Score: Int64) {
        self.name = name
        self.email = email
        self.password = password
        self.age = age
        self.game_score = game_Score
        
    }
    
}
