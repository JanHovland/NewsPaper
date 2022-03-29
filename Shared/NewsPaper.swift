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

struct NewsPaper: View {
    var body: some View {
        if apiKey.count == 32 {
            NavigationView {
                Text("Hello, NewsPaper!")
                    .padding()
            }
            #if os(macOS)
                .frame(width: 500, height: 300)
            #endif
        } else {
            NewsPaperApiKey()
        }
    }
}

