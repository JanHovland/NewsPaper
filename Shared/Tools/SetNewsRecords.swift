//
//  SetNewsRecords.swift
//  NewsPaper
//
//  Created by Jan Hovland on 30/03/2022.
//

import SwiftUI

func SetNewsRecords(value: News, count: Int) -> [NewsRecord] {
    var newsRecords = [NewsRecord]()
    
    for i in 0..<count {

        let newsRec = NewsRecord(// status:                    value.status,
                                 // totalResults:              value.totalResults,
                                 // article_source_id:         value.articles[i].source.id ?? "",
                                 article_source_name:       value.articles[i].source.name,
                                 article_author:            value.articles[i].author ?? "",
                                 article_title:             value.articles[i].title,
                                 article_description:       value.articles[i].description,
                                 article_url:               value.articles[i].url,
                                 article_urlToImage:        value.articles[i].urlToImage,
                                 article_publishedAt:       value.articles[i].publishedAt,
                                 article_content:           value.articles[i].content ?? "")
        
        newsRecords.append(newsRec)
    }
    
    return newsRecords
}
