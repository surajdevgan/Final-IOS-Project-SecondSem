//
//  DifficultyManager.swift
//  FinalProjectSecondSem
//
//  Created by Suraaj Devgn on 23/05/21.
//

import Foundation

class DifficultyManager {
    
    var difficulty: DifficultyOptions {
        if let difficulty = UserDefaults.standard.value(forKey: Constants.UserDefaultKeys.GameDifficulty) as? String, let difficultyOption = DifficultyOptions(rawValue: difficulty) {
            return difficultyOption
        } else {
            return .Easy
        }
    }
    
    func getAlienAparitionInterval() -> TimeInterval {
        switch difficulty {
        case .Easy:
            return 0.75
        case .Medium:
            return 0.50
        case .Hard:
            return 0.30
        }
    }
    
    func getAlienAnimationDutationInterval() -> TimeInterval {
        switch difficulty {
        case .Easy:
            return 6
        case .Medium:
            return 4.50
        case .Hard:
            return 3
        }
    }
    
}
