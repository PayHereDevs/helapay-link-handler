//
//  UWVController.swift
//  HelaPay Links
//
//  Created by HelaPay on 2022-02-09.
//

import Foundation
import UIKit

class UWVController: UIViewController{
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let request = URLRequest(url: URL(string: targetURL)!)
        
        webView.loadRequest(request)
        webView.delegate = self
    }
    
}

extension UWVController: UIWebViewDelegate{
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        if let url = request.url, url.absoluteString.hasSuffix("#HKexternal") {
            HelaPayLinkHandler().handleHelaPayLink(url)
            return false
        }
        else{
            return true;
        }
        
    }
    
}
