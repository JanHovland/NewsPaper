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
        case general
        case business
        case technology
        case entertainment
        case sport
        case science
        case health
        var id: String { self.rawValue }
    }
    
    @State var selection: Option = .general
    @State private var newsType = "general"
    @State private var newsTypeHeadline = ""

    var body: some View {
        if apiKey.count == 32 {
            NavigationView {
                VStack {
                    HStack {
                        Spacer()
                        Picker("Velg", selection: $selection) {
                            ForEach(Option.allCases, id:\.self) { option in
                                Text(option.rawValue)
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
                    .navigationBarTitle(Text(GetHeadline(option: newsType)), displayMode: .automatic)
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

func GetHeadlineX(option: String) -> LocalizedStringKey {
    var newsTypeHeadline: LocalizedStringKey = ""
    
    if option == "general" {
        newsTypeHeadline = LocalizedStringKey(NSLocalizedString("Top headlines", comment: ""))
    } else if option == "business" {
        newsTypeHeadline = LocalizedStringKey(NSLocalizedString("Business", comment: ""))
    } else if option == "technology" {
        newsTypeHeadline = LocalizedStringKey(NSLocalizedString("Technology", comment: ""))
    } else if option == "entertainment" {
        newsTypeHeadline = LocalizedStringKey(NSLocalizedString("Entertainment", comment: ""))
    } else if option == "sport" {
        newsTypeHeadline = LocalizedStringKey(NSLocalizedString("Sport", comment: ""))
    } else if option == "science" {
        newsTypeHeadline = LocalizedStringKey(NSLocalizedString("Science", comment: ""))
    } else if option == "health" {
        newsTypeHeadline = LocalizedStringKey(NSLocalizedString("Health", comment: ""))
    }

    return newsTypeHeadline
}

func GetHeadline(option: String) -> String {
    var newsTypeHeadline: String = ""
    
    if option == "general" {
        newsTypeHeadline = String(localized: "Top headlines")
    } else if option == "business" {
        newsTypeHeadline = String(localized: "Business")
    } else if option == "technology" {
        newsTypeHeadline = String(localized: "Technology")
    } else if option == "entertainment" {
        newsTypeHeadline = String(localized: "Entertainment")
    } else if option == "sport" {
        newsTypeHeadline = String(localized: "Sport")
    } else if option == "science" {
        newsTypeHeadline = String(localized: "Science")
    } else if option == "health" {
        newsTypeHeadline = String(localized: "Health")
    }

    return newsTypeHeadline
}
