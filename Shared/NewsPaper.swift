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
    
    @State private var hasConnectionPath = false
    @State private var device: LocalizedStringKey = ""
    @State private var message: LocalizedStringKey = ""
    @State private var title: LocalizedStringKey = ""
    @State private var isAlertActive = false
    
    let internetMonitor = NWPathMonitor()
    let internetQueue = DispatchQueue(label: "InternetMonitor")
    
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
                /// Sjekker internett forbindelse
                startInternetTracking()
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
    
    func startInternetTracking() {
        /// Only fires once
        guard internetMonitor.pathUpdateHandler == nil else {
            return
        }
        internetMonitor.pathUpdateHandler = { update in
            if update.status == .satisfied {
                self.hasConnectionPath = true
            } else {
                self.hasConnectionPath = false
            }
        }
        internetMonitor.start(queue: internetQueue)
#if os(iOS)
        /// Legger inn en forsinkelse på 1 sekund
        /// Uten denne, kan det komme melding selv om Internett er tilhjengelig
        sleep(1)
        if  hasConnectionPath == false {
            if UIDevice.current.localizedModel == "iPhone" {
                device = "iPhone"
            } else if UIDevice.current.localizedModel == "iPad" {
                device = "iPad"
            }
            title = device
            message = "No Internet connection for this device."
            isAlertActive.toggle()
        }
#endif
    }
}

