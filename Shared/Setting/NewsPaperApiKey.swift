//
//  NewsPaperApiKey.swift
//  NewsPaper
//
//  Created by Jan Hovland on 28/03/2022.
//

import SwiftUI
import Combine

struct NewsPaperApiKey: View {
    @ObservedObject var setting = Setting()
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("API KEY NEWSPAPER"),
                            footer: Text("Enter a valid Api key to access the NewsPaper")) {
                        TextField("Apikey", text: $setting.apiKey)
                    }
                }
                Spacer()
                Text("Press <Return> for the Home Screen")
                    .padding(.bottom, 10)
            }
            #if os(iOS)
            .navigationBarTitle(Text("Setting"), displayMode: .inline)
            .navigationBarItems(leading:
                                    HStack {
                                        Button(action: {
                                            ///
                                            /// exit(1) av slutter appen
                                            ///
                                            exit(1)
                                        }, label: {
                                            ReturnFromMenuView(text: "Return")
                                        })
                                    }
            )
            #endif
        }
    }
}
