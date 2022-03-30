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
        var err: LocalizedStringKey = ""
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=no&apiKey=" + apiKey)!
        print(url)
        
        let urlSession = URLSession.shared
        do {
            let (data, _) = try await urlSession.data(from: url)
            news = try JSONDecoder().decode(News.self, from: data)
        }
        catch {
            err = LocalizedStringKey(error.localizedDescription)
            print(err)
        }
        return (err, news)
    }
}
