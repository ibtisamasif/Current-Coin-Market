//
//  RegisterViewController.swift
//  FirstVersion
//
//  Created by Touqeer Ahmad on 4/6/18.
//  Copyright © 2018 Touqeer Ahmad. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    //    var userName:String = "";
    //    var email:String = "";
    //    var password:String = "";
    //    var confirmPassword : String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        print("Sign in button tapped")
        
        // Read values from text fields
        let userName = txtUserName.text
        let userEmail = txtEmail.text
        let userPassword = txtPassword.text
        let userConfirmPassword = txtConfirmPassword.text
        print("Sign in button tapped")
        print("\(userName)  \(userEmail)")
        // Check if required fields are not empty
        if (userName?.isEmpty)! || (userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (userConfirmPassword?.isEmpty)!
        {
            // Display alert message here
            print("User name \(String(describing: userName)) or password \(String(describing: userEmail)) is empty")
            displayMessage(userMessage: "One of the required fields is missing")
            
            return
        }
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        //Send HTTP Request to perform Sign in
        let myUrl = URL(string: "http://34.212.213.221/ccmapi/public/api/ccm/registration")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        UserDefaults.standard.set(userPassword, forKey: "UserPassword")
        let postString = ["username": userName!, "useremail": userEmail! ,"password" : userPassword! ,"cpassword":userConfirmPassword!] as [String: String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print("*************error****************")
            print(error.localizedDescription)
            displayMessage(userMessage: "Something went wrong...")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            
            if error != nil
            {
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print("error=\(String(describing: error))")
                return
            }
            
            //Let's convert response sent from a server side code to a NSDictionary object:
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    print(parseJSON)
                    
                    var JsonObject:Int = parseJSON["responseCode"] as? NSObject as! Int
                    
                    if JsonObject == 200
                    {
                        //                        //getting the user from response
                        let user = parseJSON.value(forKey: "response") as! NSDictionary
                        let userName = user.value(forKey: "name") as! String
                        let userEmail = user.value(forKey: "email") as! String
                        
                        UserDefaults.standard.set(userEmail, forKey: "UserEmail")
                        
                        print(userName)
                        print(userEmail)
                        
                        
                        DispatchQueue.main.async
                            {
                                let signInPage = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                                let appDelegate = UIApplication.shared.delegate
                                appDelegate?.window??.rootViewController = signInPage
                                
                                
                        }
                        
                        print("******* \(JsonObject)")
                    }
                    else if JsonObject == 409
                    {
                        
                        self.displayMessage(userMessage: "Invalid Password")
                        
                        
                    }
                    else if JsonObject == 17
                    {
                        
                        self.displayMessage(userMessage: "Invalid Email")
                    }
                    else{
                        
                        
                        DispatchQueue.main.async
                            {
                                
                                self.displayMessage(userMessage: "try again")
                        }
                        
                        
                    }
                    
                }
                    
                    
                else {
                    //Display an Alert dialog with a friendly error message
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                }
                
            } catch {
                
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                
                // Display an Alert dialog with a friendly error message
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print("  ******** ////  \(error)")
            }
            
        }
        task.resume()
        
    }
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            self.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
        }
    }
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }
    
}


