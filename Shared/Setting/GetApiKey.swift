//
//  GetApiKey.swift
//  NewsPaper
//
//  Created by Jan Hovland on 28/03/2022.
//

import SwiftUI

func getApiKey() -> String {
    @ObservedObject var setting = Setting()
    let apiKey : String = setting.apiKey
    return apiKey
}
