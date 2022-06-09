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
    
    enum Option: String, CaseIterable, Identifiable {
        case general        = "general"
        case business       = "business"
        case technology     = "technology"
        case entertainment  = "entertainment"
        case sport          = "sport"
        case science        = "science"
        case health         = "health"
        
        var id: String { self.rawValue }
        
        func localizedString() -> String {
            return NSLocalizedString(self.rawValue, comment: "")
        }

        static func getTitleFor(title:Option) -> String {
            return title.localizedString()
        }
        
    }
    
    @State var selection: Option = .general
    @State private var newsType = "general"
    @State private var newsTypeHeadline = ""
 
    var body: some View {
        if apiKey.count == 32 {
            NavigationView {
                VStack {
                    HStack {
//                        Spacer()
                        Picker("Select: ", selection: $selection) {
                            ForEach(Option.allCases, id:\.self) { option in
                                Text(NewsPaper.Option.getTitleFor(title: option))
                            }
                        }
                        .onChange(of: selection) { _ in
                            newsType = selection.rawValue
                            Task.init {
                                newsRecords = await RefreshNews()
                            }
                        }
                    }
                    .padding(.top, 5)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    Spacer()
#if os(macOS)
                    List {
                        ForEach(newsRecords) { newsRecord in
                            let url = URL(string: newsRecord.article_url)
                            let url1 = URL(string: newsRecord.article_urlToImage)
                            if url != nil,
                               url1 != nil {
                                NavigationLink(destination: SafariView(url: newsRecord.article_url)) {
                                    NewsPaperRowView(newsRecord: newsRecord, url: url1!)
                                }
                            }
                        }
                    }
                    .listStyle(InsetListStyle())
#elseif os(iOS)
                    List {
                        ForEach(newsRecords) { newsRecord in
                            let url = URL(string: newsRecord.article_url)
                            let url1 = URL(string: newsRecord.article_urlToImage)
                            if url != nil,
                               url1 != nil {
                                NavigationLink(destination: SafariView(url: url!)) {
                                    NewsPaperRowView(newsRecord: newsRecord, url: url1!)
                                }
                                
                            }
                        }
                    }
                    .refreshable {
                        newsRecords = await RefreshNews()
                    }
//                    .navigationBarTitle(Text(GetHeadline(option: newsType)), displayMode: .automatic)
                    .listStyle(SidebarListStyle())
#endif
                } // VStack
            } // NavigationView
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
        } // if
    } // Body
    
    func RefreshNews() async -> [NewsRecord] {
        var newsRecords = [NewsRecord]()
        
        var value : (LocalizedStringKey, News)
        await value = ServiceNews().getNews(type: newsType)
        
        let count = value.1.articles.count
        var value1 : [NewsRecord]
        
        value1 = SetNewsRecords(value: value.1, count: count)
        newsRecords = value1
        return newsRecords
    }
    
}

func GetHeadline(option: String) -> String {
    var newsTypeHeadline: String = ""
    
    if option == "general" {
        newsTypeHeadline = String(localized: "general")
    } else if option == "business" {
        newsTypeHeadline = String(localized: "business")
    } else if option == "technology" {
        newsTypeHeadline = String(localized: "technology")
    } else if option == "entertainment" {
        newsTypeHeadline = String(localized: "entertainment")
    } else if option == "sport" {
        newsTypeHeadline = String(localized: "sport")
    } else if option == "science" {
        newsTypeHeadline = String(localized: "science")
    } else if option == "health" {
        newsTypeHeadline = String(localized: "health")
    }

    return newsTypeHeadline
}
