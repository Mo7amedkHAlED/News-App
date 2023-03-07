//
//  WebKitVC.swift
//  News App
//
//  Created by Mohamed Khaled on 07/03/2023.
//

import UIKit
import WebKit

class WebKitVC: UIViewController, WKUIDelegate{
    static let ID = String(describing: WebKitVC.self)
    // MARK: - @IBOutlet
    @IBOutlet weak var webKit: WKWebView!
    // MARK: - Properties
    var urlString = ""
    var progressBar =  UIProgressView()
    // MARK: -  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        progressBar = UIProgressView(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 20))
        view.addSubview(progressBar)
        if let url = URL(string: urlString){
            webKit.load( URLRequest(url: url))
            // Load the web page
        
            webKit.load(URLRequest(url: url))

            // Observe the estimatedProgress property of the web view
            webKit.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        }
        progressBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        super.viewWillDisappear(animated)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressBar.progress = Float(webKit.estimatedProgress)
        }
    }

}
