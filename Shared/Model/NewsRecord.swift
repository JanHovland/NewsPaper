//
//  NewsRecord.swift
//  NewsPaper
//
//  Created by Jan Hovland on 30/03/2022.
//

import Foundation

struct NewsRecord: Identifiable {
    var id = UUID()
    var article_title  = String()
    var article_url = String()
}
