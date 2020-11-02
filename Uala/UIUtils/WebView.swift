//
//  WebView.swift
//  Uala
//
//  Created by Jose Chourio on 11/2/20.
//  Copyright © 2020 Jose Chourio. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let videoUrlString: String
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        
    }
    
    func makeUIView(context: Context) -> WKWebView {
        guard let playerUrl = URL.init(string: videoUrlString) else {
            return WKWebView()
        }
        let request = URLRequest(url: playerUrl)
        let wkWebView = WKWebView()
        wkWebView.load(request)
        return wkWebView
    }
}
