//
//  SetNewsRecords.swift
//  NewsPaper
//
//  Created by Jan Hovland on 30/03/2022.
//

import SwiftUI

func SetNewsRecords(value: News, count: Int) -> [NewsRecord] {
    var newsRecords = [NewsRecord]()
    
    
    /// description, urlToImage og content er alle 'null'
    
    for i in 0..<count {
        let newsRec = NewsRecord(article_title:             value.articles[i].title,
                                 article_url:               value.articles[i].url)
        
        newsRecords.append(newsRec)
        
    }
    return newsRecords
}
