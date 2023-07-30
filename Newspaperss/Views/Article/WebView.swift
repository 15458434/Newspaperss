//
//  WebView.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 30/07/2023.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    // MARK: UIViewRepresentable
    
    func makeUIView(context: Context) -> WKWebView {
        let new = WKWebView()
        return new
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let urlRequest = URLRequest(url: url)
        uiView.load(urlRequest)
    }
}
