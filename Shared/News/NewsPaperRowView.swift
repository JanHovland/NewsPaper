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
                        #if os(iOS)
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 400, maxHeight: 200)
                        #elseif os(macOS)
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 400, maxHeight: 100)
                        #endif
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
#if os(macOS)
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

