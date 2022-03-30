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
    
    var body: some View {
        if apiKey.count == 32 {
            NavigationView {
                Text("Hello, NewsPaper!")
                    .padding()
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
                
                await RefreshNews()
                
                
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
    
}



