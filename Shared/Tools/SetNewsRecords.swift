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
        let newsRec = NewsRecord(article_source_name:       value.articles[i].source.name,
                                 article_author:            value.articles[i].author,
                                 article_title:             value.articles[i].title,
                                 article_url:               value.articles[i].url,
                                 article_publishedAt:       value.articles[i].publishedAt)
        
        newsRecords.append(newsRec)
        
    }
    return newsRecords
}
