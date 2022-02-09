//
//  HelaPayLinkHandler.swift
//  HelaPay Links
//
//  Created by HelaPay on 2022-02-09.
//

import Foundation
import UIKit

final class HelaPayLinkHandler{
    
    private static var session: URLSession!
    private let taskDelegate: HelaPayLinkHandlerDelegate!
    
    private class HelaPayLinkHandlerDelegate: NSObject, URLSessionTaskDelegate{
        override init(){
            super.init()
        }
        
        func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
            completionHandler(nil)
        }
    }
    
    init(){
        taskDelegate = HelaPayLinkHandlerDelegate()
        if HelaPayLinkHandler.session == nil{
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForResource = 5
            config.timeoutIntervalForResource = 10
            HelaPayLinkHandler.session = URLSession(
                configuration: config,
                delegate: taskDelegate,
                delegateQueue: nil
            )
        }
    }
    
    func handleHelaPayLink(_ url: URL){
        let request = URLRequest(url: url)
        
        HelaPayLinkHandler.session.dataTask(with: request) { _, res, err in
            DispatchQueue.main.async {
                guard err == nil, let cres = res as? HTTPURLResponse else {
                    #if DEBUG
                    print("handleHelaPayLink", err ?? "Unknown error occurred")
                    #endif
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    return
                }
                
                if let link = cres.allHeaderFields["Location"] as? String, let deepLink = URL(string: link){
                    UIApplication.shared.open(deepLink, options: [:], completionHandler: nil)
                }
                else{
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }.resume()
    }
    
    
}
