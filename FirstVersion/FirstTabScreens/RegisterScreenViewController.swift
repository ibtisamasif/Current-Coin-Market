//
//  RegisterScreenViewController.swift
//  FirstVersion
//
//  Created by Touqeer Ahmad on 3/26/18.
//  Copyright © 2018 Touqeer Ahmad. All rights reserved.
//

import UIKit

class RegisterScreenViewController: UIViewController {

    @IBOutlet weak var webViewURL: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://34.212.213.221/ccm/public/members/create")
        let request = URLRequest(url: url!)
        webViewURL.loadRequest(request)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
