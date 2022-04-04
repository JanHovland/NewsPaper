//
//  ServiceNews.swift
//  NewsPaper
//
//  Created by Jan Hovland on 30/03/2022.
//

import Foundation
import SwiftUI

class ServiceNews: ObservableObject {
    @Published var news = News()
    
    func getNews() async -> (LocalizedStringKey, News) {
        
        @ObservedObject var menuSelect = MenuSelect()
        var err: LocalizedStringKey = ""
        var url = "https://newsapi.org/v2/top-headlines?"
        url += "apiKey=\(apiKey)"
        url += "&language=no"
        url += "&category=\(menuSelect.menu)"
        
        print(url as Any)
        
        let urlSession = URLSession.shared
        
        do {
            let (data, _) = try await urlSession.data(from: URL(string: url)!)
            news = try JSONDecoder().decode(News.self, from: data)
        }
        catch {
            err = LocalizedStringKey(error.localizedDescription)
            print(err)
        }
        return (err, news)
    }
}
