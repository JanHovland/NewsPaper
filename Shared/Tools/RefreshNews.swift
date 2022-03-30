//
//  RefreshNews.swift
//  NewsPaper
//
//  Created by Jan Hovland on 30/03/2022.
//

import SwiftUI

func RefreshNews() async {
    Task.init {
        
        var value : (LocalizedStringKey, News)
        await value = ServiceNews().getNews()

        print(value.1)
        
    }
    
}
