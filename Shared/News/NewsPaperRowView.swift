//
//  NewsPaperRowView.swift
//  NewsPaper
//
//  Created by Jan Hovland on 31/03/2022.
//

import SwiftUI

struct NewsPaperRowView: View {
    
    var newsRecord: NewsRecord
    var url: URL
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            VStack {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        HStack {
                            Spacer()
                            Image(systemName: "photo")
                                .imageScale(.large)
                            Spacer()
                        }
                    @unknown default:
                        fatalError()
                    }
                }
            }
#if os(iOS)
            .frame(minHeight: 200, maxHeight: 300)
            .background(Color.gray.opacity(0.3))
            .clipped()
#elseif os(macOS)
            .frame(width: 400, height: 100)
            .background(Color.gray.opacity(0.3))
            .clipped()
            
#endif
            
            VStack(alignment: .leading, spacing: 8) {
                Text(newsRecord.article_title)
                // Text(newsRecord.article_description)
                    .font(Font.title3.weight(.light))
                Text(newsRecord.article_content)
                    .font(Font.callout.weight(.light))
                    .foregroundColor(.green)
            }
        }
    }
}

