//
//  SafariView.swift
//  NewsPaper
//
//  Created by Jan Hovland on 31/03/2022.
//

import SwiftUI
import SafariServices
import WebKit

#if os(iOS)
struct SafariView: UIViewControllerRepresentable {
    
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }
    
}
#elseif os(macOS)
/// Grunnen til at denne "ikke virket" var følgende:
/// Det mangler avhuking på :
///     Incoming Connections (Server)
///     Outgoing xonnections (Client) under:
///         TARGETS Articles (macOS) under
///             Signing & Capabilities under tab : All

struct SafariView : NSViewRepresentable {
    
    var url: String
    
    func updateNSView(_ nsView: WKWebView, context: Context) {

    }
    
    func makeNSView(context: Context) -> WKWebView  {
        let view = WKWebView()
        if let url = URL(string: url) {
            view.load(URLRequest(url: url))
        }
        return view
    }
}
#endif


