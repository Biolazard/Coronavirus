//
//  WebViewViewController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 06/03/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var web: WKWebView!
    var webView = WKWebView()
    var url: URL!
    
    func dependencyInjection(url: URL) {
        self.url = url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        web.navigationDelegate = self
        web.load(URLRequest(url: url))
        
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activity.stopAnimating()
    }

}
