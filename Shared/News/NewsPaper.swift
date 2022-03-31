//
//  NewsPaper.swift
//  Shared
//
//  Created by Jan Hovland on 28/03/2022.
//

//
// Alle topp nyhetene fra Norge  
// https://newsapi.org/v2/top-headlines?country=no&apiKey=ApiKey
//

var apiKey = getApiKey()

import SwiftUI
import Network

struct NewsPaper: View {
    
    @State private var message: LocalizedStringKey = ""
    @State private var title: LocalizedStringKey = ""
    @State private var isAlertActive = false
    
    @State private var newsRecords = [NewsRecord]()
    
    var body: some View {
        if apiKey.count == 32 {
            NavigationView {
                List {
                    ForEach(newsRecords) { newsRecord in
                        Text(newsRecord.article_title)
                        Text(newsRecord.article_description)
                            .font(Font.footnote.weight(.light))
                            .foregroundColor(.green)
                    }
                }
            }
#if os(macOS)
            .frame(width: 500, height: 300)
#endif
            .task {
                /// Sjekker om internet er tilkoplet
                var value : (Bool, LocalizedStringKey)
                value = ConnectToInternet()
                if value.0 == false {
                    title = value.1
                    message = "No Internet connection for this device."
                    isAlertActive.toggle()
                }
                newsRecords = await RefreshNews()
            }
            .alert(title, isPresented: $isAlertActive) {
                Button("OK", action: {})
            } message: {
                Text(message)
            }
        } else {
            NewsPaperApiKey()
        }
    }
    
    func RefreshNews() async -> [NewsRecord] {
        var newsRecords : [NewsRecord]
        
        var value : (LocalizedStringKey, News)
        await value = ServiceNews().getNews()
        
        let count = value.1.articles.count
        var value1 : [NewsRecord]
        
        value1 = SetNewsRecords(value: value.1, count: count)
        newsRecords = value1
        return newsRecords
    }
    
}



