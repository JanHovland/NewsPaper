//
//  NewsPaperApp.swift
//  Shared
//
//  Created by Jan Hovland on 28/03/2022.
//

import SwiftUI

@main
struct NewsPaperApp: App {
     
    var body: some Scene {
        
        
        WindowGroup {
            NewsPaper()
        }
        .commands {
            CommandMenu("Custom Menu") {
                Menu("Refresh") {
                    Button(action: {
                    }, label: {
                        Text("Sub Item 1")
                    })
                    Divider()
                    Button(action: {}, label: {
                        Text("Sub Item 2")
                    })
                    Divider()
                    Button(action: {}, label: {
                        Text("Sub Item 3")
                    })
                }            }
        }
    }
}
