//
//  LogoutViewController.swift
//  FirstVersion
//
//  Created by Touqeer Ahmad on 4/4/18.
//  Copyright © 2018 Touqeer Ahmad. All rights reserved.
//

import UIKit

class LogoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
    
    }
    @IBAction func Logout(_ sender: Any) {
        
 UserDefaults.standard.set("", forKey: "UserPassword")
        CoreDataHandler.cleanDelete()
        CheckLoginORNotViewController.instanceshared.logout()
        let signInPage = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = signInPage
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
