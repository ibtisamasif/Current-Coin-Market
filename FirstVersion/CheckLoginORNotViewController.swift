//
//  CheckLoginORNotViewController.swift
//  FirstVersion
//
//  Created by Touqeer Ahmad on 4/4/18.
//  Copyright © 2018 Touqeer Ahmad. All rights reserved.
//

import UIKit

class CheckLoginORNotViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    
        
        UserDefaults.standard.set(0 , forKey: "UserID")
        UserDefaults.standard.set("", forKey: "UserName")
        UserDefaults.standard.set("", forKey: "UserEmail")
        UserDefaults.standard.set("",forKey: "UserDob")
        UserDefaults.standard.set("", forKey: "UserMname")
        UserDefaults.standard.set("",forKey: "UserIname")
        UserDefaults.standard.set(0, forKey: "UserZip")
        UserDefaults.standard.set("", forKey: "UserAddress")
        UserDefaults.standard.set("", forKey: "UserGender")
        UserDefaults.standard.set("", forKey: "UserFax")
        UserDefaults.standard.set("", forKey: "UserPhone")
        UserDefaults.standard.set("", forKey: "UserMobile")
        UserDefaults.standard.set("", forKey: "UserToken")
        UserDefaults.standard.set("", forKey: "UserProfileImage")
         UserDefaults.standard.set("", forKey: "UserPassword")
        
        print("  *********View Did Load***************  ")
      
        // Do any additional setup after loading the view.
    }
    
    
    static let instanceshared = CheckLoginORNotViewController()

    func logout() {
        
        UserDefaults.standard.set(0 , forKey: "UserID")
        UserDefaults.standard.set("", forKey: "UserName")
        UserDefaults.standard.set("", forKey: "UserEmail")
        UserDefaults.standard.set("",forKey: "UserDob")
        UserDefaults.standard.set("", forKey: "UserMname")
        UserDefaults.standard.set("",forKey: "UserIname")
        UserDefaults.standard.set(0, forKey: "UserZip")
        UserDefaults.standard.set("", forKey: "UserAddress")
        UserDefaults.standard.set("", forKey: "UserGender")
        UserDefaults.standard.set("", forKey: "UserFax")
        UserDefaults.standard.set("", forKey: "UserPhone")
        UserDefaults.standard.set("", forKey: "UserMobile")
        UserDefaults.standard.set("", forKey: "UserToken")
        UserDefaults.standard.set("", forKey: "UserProfileImage")
           UserDefaults.standard.set("", forKey: "UserPassword")
    }
    func login(id : Int , name : String , email : String , dob : String , mname : String , iname : String , zip : Int , address: String , gender : String , fax : String , phone : String , mobile : String , token : String , image : String) {
        print("In login function")
        print(id)
        print(name)
        print(email)
        
        UserDefaults.standard.set(id , forKey: "UserID")
        UserDefaults.standard.set(name, forKey: "UserName")
        UserDefaults.standard.set(email, forKey: "UserEmail")
        UserDefaults.standard.set(dob,forKey: "UserDob")
        UserDefaults.standard.set(mname, forKey: "UserMname")
        UserDefaults.standard.set(iname,forKey: "UserIname")
        UserDefaults.standard.set(zip, forKey: "UserZip")
        UserDefaults.standard.set(address, forKey: "UserAddress")
        UserDefaults.standard.set(gender, forKey: "UserGender")
        UserDefaults.standard.set(fax, forKey: "UserFax")
        UserDefaults.standard.set(phone, forKey: "UserPhone")
        UserDefaults.standard.set(mobile, forKey: "UserMobile")
        UserDefaults.standard.set(token, forKey: "UserToken")
        UserDefaults.standard.set(image, forKey: "UserProfileImage")
        
        //        var s = UserDefaults.standard.set(userToken, forKey: "UserToken")
        //
        //        print("*********\(s)**************")
        //
        
    }
    
    func isLogIn() -> Bool
    {
        
        var  check:Bool  = true
        
        var userToken = (UserDefaults.standard.object(forKey: "UserToken") as? String)!
        //var userToken = ""
        print(userToken)
        if userToken == ""
        {
            let signInPage = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = signInPage
            check = false
        }
        else
        {
            
            check = true
            if let tabbar = (self.storyboard?.instantiateViewController(withIdentifier: "tabTwo") as? UITabBarController) {
                self.present(tabbar, animated: true, completion: nil)
                
            }
        }
        
        return check
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
                var userToken = (UserDefaults.standard.object(forKey: "UserToken") as? String)!
               // var userToken = ""
                print(userToken)
                if userToken == ""
                {
                    let signInPage = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                    let appDelegate = UIApplication.shared.delegate
                    appDelegate?.window??.rootViewController = signInPage
        
                }
                else
                {
                    if let tabbar = (self.storyboard?.instantiateViewController(withIdentifier: "tabTwo") as? UITabBarController) {
                        self.present(tabbar, animated: true, completion: nil)
        
                    }
                }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
