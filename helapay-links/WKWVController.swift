//
//  WKWVController.swift
//  linkavertinguiwv
//
//  Created by HelaPay on 2022-02-09.
//

import Foundation
import UIKit
import WebKit

class WKWVController: UIViewController{
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let request = URLRequest(url: URL(string: targetURL)!)
        
        webView.load(request)
        webView.navigationDelegate = self
    }
    
}

extension WKWVController: WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url = navigationAction.request.url, url.absoluteString.hasSuffix("#HKexternal") {
            HelaPayLinkHandler().handleHelaPayLink(url)
            decisionHandler(.cancel)
        }
        else{
            decisionHandler(.allow)
        }
        
    }
    
}
