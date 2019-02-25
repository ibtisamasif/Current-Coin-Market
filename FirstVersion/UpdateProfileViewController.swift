//
//  UpdateProfileViewController.swift
//  FirstVersion
//
//  Created by Touqeer Ahmad on 4/2/18.
//  Copyright © 2018 Touqeer Ahmad. All rights reserved.
//

import UIKit

class UpdateProfileViewController: UIViewController {
    
    @IBOutlet weak var uiImageView: UIImageView!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtaddress: UITextField!
    @IBOutlet weak var txtMname: UITextField!
    @IBOutlet weak var txtIname: UITextField!
    @IBOutlet weak var txtDateOfBirth: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    
    
    var UserName = ""
    var UserEmail = ""
    var UserDod  = ""
    var UserIname = ""
    var UserMname = ""
    var UserAddress = ""
    var UserPhone = ""
    var UserMobile = ""
    var UserImage = ""
    var UserToken = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserToken = (UserDefaults.standard.object(forKey: "UserToken") as? String)!
        UserName = (UserDefaults.standard.object(forKey: "UserName") as? String)!
        UserEmail = (UserDefaults.standard.object(forKey: "UserEmail") as? String)!
        UserDod = (UserDefaults.standard.object(forKey: "UserDob") as? String)!
        UserIname = (UserDefaults.standard.object(forKey: "UserIname") as? String)!
        UserMname = (UserDefaults.standard.object(forKey: "UserMname") as? String)!
        UserAddress = (UserDefaults.standard.object(forKey: "UserAddress") as? String)!
        UserPhone = (UserDefaults.standard.object(forKey: "UserPhone") as? String)!
        UserMobile = (UserDefaults.standard.object(forKey: "UserMobile") as? String)!
        UserImage = (UserDefaults.standard.object(forKey: "UserProfileImage") as? String)!
        
        txtName.text = UserName
        txtEmail.text = UserEmail
        txtDateOfBirth.text = UserDod
        txtIname.text = UserIname
        txtMname.text = UserMname
        txtaddress.text = UserAddress
        txtMobile.text = UserMobile
        txtPhone.text = UserPhone
        
        
        let url = URL(string:UserImage)
        
       print("********\(UserImage)********")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async() {    // execute on main thread
                self.uiImageView.image = UIImage(data: data)
            }
        }
        
task.resume()
        
        
    }
    
    
    
    func postRequestToServer()
    {
        
        
        UserName = txtName.text!
        UserEmail = txtEmail.text!
        UserDod = txtDateOfBirth.text!
        UserIname = txtIname.text!
        UserMname = txtMname.text!
        UserAddress = txtaddress.text!
        UserMobile = txtMobile.text!
        UserPhone = txtPhone.text!
        
        
        let myUrl = URL(string: "http://34.212.213.221/ccmapi/public/api/ccm/update/?token=\(UserToken)&name=\(UserName)&mname=\(UserMname)&lname=\(UserIname)&dob=\(UserDod)&zip=5400&town&gender&address=\(UserAddress)&state&fax&phone=\(UserPhone)&mobile=\(UserMobile)&image")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "PUT"// Compose a query string
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
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
                    
                    var JsonObject:Int = parseJSON["responseCode"] as? NSObject as! Int
                    
                    if JsonObject == 200
                    {
                        //getting the user from response
                        let user = parseJSON.value(forKey: "response") as! NSDictionary
                        let userAddress = user.value(forKey: "address") as! String
                        let userDob = user.value(forKey: "dob") as! String
                        let userFax = user.value(forKey: "fax") as! String
                        let userGender = user.value(forKey: "gender") as! String
                        let userImageURL = user.value(forKey: "image") as! String
                        let userlname = user.value(forKey: "last_name") as! String
                        let userMname = user.value(forKey: "middle_name") as! String
                        let userMobile = user.value(forKey: "mobile") as! String
                        let userName = user.value(forKey: "name") as! String
                        let userPhone = user.value(forKey: "phone") as! String
                        let userState = user.value(forKey: "state") as! String
                        let userTown = user.value(forKey: "town") as! String
                        let userZip = user.value(forKey: "zip") as! String
                        
                        print(userAddress)
                        print(userDob)
                        print(userFax)
                        print(userGender)
                        print(userImageURL)
                        print(userlname)
                        print(userMname)
                        print(userMobile)
                        print(userName)
                        print(userMobile)
                        
                        
                        UserDefaults.standard.set(userName, forKey: "UserName")
                        UserDefaults.standard.set(userDob, forKey: "UserDod")
                        UserDefaults.standard.set(userMname, forKey: "UserMname")
                        UserDefaults.standard.set(userlname, forKey: "UserIname")
                        UserDefaults.standard.set(userZip, forKey: "UserZip")
                        UserDefaults.standard.set(userTown, forKey: "UserTown")
                        UserDefaults.standard.set(userState, forKey: "UserState")
                        UserDefaults.standard.set(userAddress, forKey: "UserAddress")
                        UserDefaults.standard.set(userGender, forKey: "UserGender")
                        UserDefaults.standard.set(userFax, forKey: "UserFax")
                        UserDefaults.standard.set(userPhone, forKey: "UserPhone")
                        UserDefaults.standard.set(userMobile, forKey: "UserMobile")
                        UserDefaults.standard.set(userImageURL, forKey: "UserProfileImage")
                        
                        
                        print(user)
                        print("*****")
                        print("****")
                        print(userName)
                        print("****")
                        print("****")
                        print("****")
                        
                        DispatchQueue.main.async
                            {
                                //                                if let tabbar = (self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as? UITabBarController) {
                                //                                    self.present(tabbar, animated: true, completion: nil)
                                //                                }
                                
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
                    else if JsonObject == 300
                    {
                        
                        self.displayMessage(userMessage: "Invaliddf   Email")
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
                
                
                
                // Display an Alert dialog with a friendly error message
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print("  ******** ////  \(error)")
            }
            
        }
        task.resume()
        
        
    }
    
    @IBAction func btnUpdate(_ sender: Any) {
        
        
        postRequestToServer()
           self.displayMessage(userMessage: "Enter Successfully")
        
        
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
                            let UpdateProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "UpdateProfileViewController") as! UpdateProfileViewController
                            let appDelegate = UIApplication.shared.delegate
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

