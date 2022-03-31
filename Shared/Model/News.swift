//
//  News.swift
//  NewsPaper
//
//  Created by Jan Hovland on 28/03/2022.
//

import Foundation

// MARK: - News
struct News: Decodable {
//    var status =  String()
//    var totalResults = Int()
    var articles = [Article]()
}

// MARK: - Article
struct Article: Decodable {
    var source = Source()
    var author : String?
    var title  = String()
    var description = String()
    var url = String()
    var urlToImage = String()
    var publishedAt = String()
    var content: String?
}

// MARK: - Source
struct Source: Decodable {
//    var id : String?
    var name = String()
}
