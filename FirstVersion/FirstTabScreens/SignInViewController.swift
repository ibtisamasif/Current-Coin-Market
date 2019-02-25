//
//  LoginScreenViewController.swift
//  FirstVersion
//
//  Created by Touqeer Ahmad on 3/22/18.
//  Copyright © 2018 Touqeer Ahmad. All rights reserved.
//

import Foundation
import UIKit


class SignInViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    var email = "";
    var password = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        email = (UserDefaults.standard.object(forKey: "UserEmail") as? String)!
        userNameTextField.text = email
        password = (UserDefaults.standard.object(forKey: "UserPassword") as? String)!
        userPasswordTextField.text = password
        
    }
    @IBAction func signInButtonTapped(_ sender: Any) {
        print("Sign in button tapped")
        
        email = userNameTextField.text!
        password = userPasswordTextField.text!
        
        // Read values from text fields
        //        (UserDefaults.standard.object(forKey: "UserEmail") as? String)!
        //        le(UserDefaults.standard.object(forKey: "UserPassword") as? String)!
        print("\(email)  \(password)")
        // Check if required fields are not empty
        if (email.isEmpty) || (password.isEmpty)
        {
            // Display alert message here
            print("User name \(String(describing: email)) or password \(String(describing: password)) is empty")
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
        let myUrl = URL(string: "http://34.212.213.221/ccmapi/public/api/ccm/authenticate")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let postStrings = ["email": email, "password": password] as [String: String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postStrings, options: .prettyPrinted)
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
                print(json)
                if let parseJSON = json {
                    print(parseJSON)
                    
                    let JsonObject:Int = parseJSON["responseCode"] as? NSObject as! Int
                    
                    if JsonObject == 200
                    {
                        //getting the user from response
                        let user = parseJSON.value(forKey: "response") as! NSDictionary
                        
                        
                        var userId = 0
                        if user.value(forKey: "id") is Int{
                            userId = user.value(forKey: "id") as! Int
                        }
                        
                        
                        var userName = ""
                        
                        if user.value(forKey: "name") is String{
                            
                            
                            userName = user.value(forKey: "name") as! String
                        }
                        
                        
                        var userEmail = ""
                        if user.value(forKey: "email") is String{
                            
                            userEmail = user.value(forKey: "email") as! String
                            
                        }
                        
                        
                        var userDob = ""
                        if user.value(forKey: "dob") is String{
                            userDob = user.value(forKey: "dob") as! String
                        }
                        
                        var  userMname = ""
                        
                        if  user.value(forKey: "mname") is String{
                            
                            userMname = user.value(forKey: "mname") as! String
                        }
                        
                        var  userIname = ""
                        
                        if user.value(forKey: "lname") is String
                        {
                            userIname = user.value(forKey: "lname") as! String
                            
                        }
                        
                        var  userZip = 0
                        
                        if user.value(forKey: "zip") is Int
                        {
                            userZip = user.value(forKey: "zip") as! Int
                            
                        }
                        
                        
                        var  userAddress = ""
                        
                        if user.value(forKey: "address") is String
                        {
                            userAddress = user.value(forKey: "address") as! String
                            
                        }
                        var  userGender = ""
                        
                        if user.value(forKey: "gender") is String
                        {
                            userGender = user.value(forKey: "gender") as! String
                            
                        }
                        var  userFax = ""
                        
                        if user.value(forKey: "fax") is String
                        {
                            userFax = user.value(forKey: "fax") as! String
                            
                        }
                        var  userPhone = ""
                        
                        if user.value(forKey: "phone") is String
                        {
                            userPhone = user.value(forKey: "phone") as! String
                            
                        }
                        
                        var  userMobile = ""
                        
                        if user.value(forKey: "mobile") is String
                        {
                            userMobile = user.value(forKey: "mobile") as! String
                            
                        }
                        var  userToken = ""
                        
                        if user.value(forKey: "token") is String
                        {
                            userToken = user.value(forKey: "token") as! String
                            
                        }
                        
                        var  userImageURL = ""
                        
                        if user.value(forKey: "image url") is String
                        {
                            userImageURL = user.value(forKey: "image url") as! String
                            
                        }
             
//                        
//                        CheckLoginORNotViewController.instanceshared.login(userToken: userToken)
                        
                        UserDefaults.standard.set(userId , forKey: "UserID")
                        UserDefaults.standard.set(userName, forKey: "UserName")
                        UserDefaults.standard.set(userEmail, forKey: "UserEmail")
                        UserDefaults.standard.set(userDob,forKey: "UserDob")
                        UserDefaults.standard.set(userMname, forKey: "UserMname")
                        UserDefaults.standard.set(userIname,forKey: "UserIname")
                        UserDefaults.standard.set(userZip, forKey: "UserZip")
                        UserDefaults.standard.set(userAddress, forKey: "UserAddress")
                        UserDefaults.standard.set(userGender, forKey: "UserGender")
                        UserDefaults.standard.set(userFax, forKey: "UserFax")
                        UserDefaults.standard.set(userPhone, forKey: "UserPhone")
                        UserDefaults.standard.set(userMobile, forKey: "UserMobile")
                        UserDefaults.standard.set(userToken, forKey: "UserToken")
                        UserDefaults.standard.set(userImageURL, forKey: "UserProfileImage")
                        
                        
                        CheckLoginORNotViewController.instanceshared.login(id: userId , name: userName , email: userEmail , dob: userDob , mname:userMname , iname: userIname , zip: userZip , address : userAddress , gender : userGender , fax : userFax , phone  : userPhone , mobile : userMobile , token : userToken , image: userImageURL)
                        
                        
                        
                        print(user)
                        print("*****")
                        print(userId)
                        print("****")
                        print(userName)
                        print("****")
                        print(userEmail)
                        print("****")
                        // print(userPhone)
                        print("****")
                        
                        DispatchQueue.main.async
                            {
                                if let tabbar = (self.storyboard?.instantiateViewController(withIdentifier: "tabTwo") as? UITabBarController) {
                                    self.present(tabbar, animated: true, completion: nil)
                                }
                                
                        }
                        print("******* \(JsonObject)")
                    }
                    else if JsonObject == 5
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
