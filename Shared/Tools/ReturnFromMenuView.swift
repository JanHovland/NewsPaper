//
//  ReturnFromMenuView.swift
//  NewsPaper
//
//  Created by Jan Hovland on 28/03/2022.
//

import SwiftUI

struct ReturnFromMenuView: View {
    var text: String
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .frame(width: 11, height: 18, alignment: .center)
            Text(text)
        }
        .foregroundColor(.accentColor)
        .font(Font.headline.weight(.regular))
    }
}
