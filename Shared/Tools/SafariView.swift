//
//  SafariView.swift
//  NewsPaper
//
//  Created by Jan Hovland on 31/03/2022.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    
    var url: URL
    
    func makeUIViewController(context: Context) -> some SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
}
