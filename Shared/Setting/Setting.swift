//
//  Setting.swift
//  NewsPaper
//
//  Created by Jan Hovland on 28/03/2022.
//

import Foundation
import Combine

///
/// Settings bundle virker kun i iOS og ikke i Mac Catalyst
/// Måtte derfor lage noe som er felles.
///

class Setting: ObservableObject {
    @Published var apiKey: String {
        didSet {
            UserDefaults.standard.set(apiKey, forKey: "API_KEY")
        }
    }
    
    init() {
        self.apiKey = UserDefaults.standard.object(forKey: "API_KEY") as? String ?? ""
    }
}
