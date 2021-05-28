//
//  DifficultyOptions.swift
//  FinalProjectSecondSem
//
//  Created by Suraaj Devgn on 23/05/21.
//

import Foundation

enum DifficultyOptions: String, CaseIterable {
    case Easy, Medium, Hard
    
    var description: String {
        switch self {
        case .Easy:
            return "Easy"
        case .Medium:
            return "Medium"
        case .Hard:
            return "Hard"
        }
    }
}
