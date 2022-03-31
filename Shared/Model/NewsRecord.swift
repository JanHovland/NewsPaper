//
//  NewsRecord.swift
//  NewsPaper
//
//  Created by Jan Hovland on 30/03/2022.
//

import Foundation

struct NewsRecord: Identifiable {
    var id = UUID()
    var article_source_name = String()
    var article_author : String?
    var article_title  = String()
    var article_description = String()
    var article_url = String()
    var article_urlToImage = String()
    var article_publishedAt = String()
    var article_content = String()
}
