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
    
    enum Category: String, CaseIterable, Identifiable {
        case general
        case business
        case technology
        case entertainment
        case sports
        case science
        case health
        
        var id: String { self.rawValue }
        
    }
    
    @State var selection: Category = .general
    
    @ObservedObject var menuSelect = MenuSelect()
    
    fileprivate func funcMenu(_ menu: String, _ menuText: String, _ image: String) -> Button<Label<Text, Image>> {
        return Button {
            Task.init {
                menuSelect.menu = menu
                menuSelect.menuText = menuText
                newsRecords = await RefreshNews()
            }
        } label: {
            Label(menuText, systemImage: image)
        }
    }
    
    var body: some View {
        if apiKey.count == 32 {
            NavigationView {
#if os(iOS)
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
                .navigationBarTitle(Text(menuSelect.menuText))
                .listStyle(SidebarListStyle())
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        ControlGroup {
                            Button {
                                /// Rutine for å friske opp personoversikten
                                Task.init {
                                    newsRecords = await RefreshNews()
                                }
                            } label: {
                                Text("Refresh")
                                    .font(Font.headline.weight(.light))
                            }
                        }
                        .controlGroupStyle(.navigation)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Picker(selection: $selection,
//                               label: Image(systemName: "fiberchannel"),
//                               content: {
//                            ForEach(Category.allCases) { category in
//                                Text(category.rawValue.capitalized).tag(category)
//                            }
//                        })
//                        .padding()
//                        .pickerStyle(MenuPickerStyle())
                        Image(systemName: "ellipsis.circle" )
                           .foregroundColor(.accentColor)
                           .font(Font.body.weight(.regular))
                           .contextMenu {
                               funcMenu("general", "Top Headlines", "square.and.pencil")
                               funcMenu("sport", "Sport", "square.and.pencil")
                           }
                        
                    }})
#endif
                
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
#endif
                
            } // NavigationView
            
#if os(macOS)
            .frame(width: 700, height: 400)
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
                
                menuSelect.menu = "general"
                menuSelect.menuText = "Top Headlines"
                
                
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
        var newsRecords = [NewsRecord]()
        
        var value : (LocalizedStringKey, News)
        await value = ServiceNews().getNews()
        
        let count = value.1.articles.count
        var value1 : [NewsRecord]
        
        value1 = SetNewsRecords(value: value.1, count: count)
        newsRecords = value1
        return newsRecords
    }
    
}



