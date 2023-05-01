//
//  News.swift
//  NewsPaper
//
//  Created by Jan Hovland on 28/03/2022.
//

import Foundation

// MARK: - News
struct News: Decodable {
    var articles = [Article]()
}

// MARK: - Article
struct Article: Decodable {
    var title  = String()
    var url = String()
}

