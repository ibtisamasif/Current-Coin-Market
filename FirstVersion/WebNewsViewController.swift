//
//  WebNewsViewController.swift
//  FirstVersion
//
//  Created by Touqeer Ahmad on 4/11/18.
//  Copyright © 2018 Touqeer Ahmad. All rights reserved.
//

import UIKit
import WebKit
class WebNewsViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var articale:Article?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(" *****************    " + (articale?.url)!)
        let url = URL(string: (articale?.url)!)
        let request = URLRequest(url: url!)
        webView.load(request)
        
    }
    
    @IBAction func backButton(_ sender: Any) {
           self.navigationController?.popViewController(animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
}
