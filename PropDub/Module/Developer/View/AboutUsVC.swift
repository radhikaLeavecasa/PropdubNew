//
//  AboutUsVC.swift
//  PropDub
//
//  Created by acme on 03/06/24.
//

import UIKit
import WebKit

class AboutUsVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var webView: WKWebView!
    //MARK: - Variables
    var url = String()
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        if let url2 = URL(string: url) {
            let urlRequest = URLRequest(url: url2)
            webView.load(urlRequest)
        }
    }
    //MARK: - @IBActions
    @IBAction func actionBack(_ sender: Any) {
        popView()
    }
}
