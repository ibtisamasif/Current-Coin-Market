//
//  ViewControllerForAddCoin.swift
//  FirstVersion
//
//  Created by Touqeer Ahmad on 3/28/18.
//  Copyright © 2018 Touqeer Ahmad. All rights reserved.
//
struct Coin : Decodable {
    
    var name : String
    var symbol : String
    var rank : String
    var price_usd : String
    
}

import UIKit

class ViewControllerForAddCoin: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var txtCoinName: UITextField!
    @IBOutlet weak var txtCurrency: UITextField!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    var addcoin:[AddCoin]? = nil
    let colors = ["btc" , "thr" , "yhn"]
    var coinsArray = [Coin]()
    @IBOutlet weak var pickerView: UIPickerView!
    
    private var jsonURL = "https://api.coinmarketcap.com/v1/ticker/?start=0&limit=200"
    
    var nameArray = [String]()
    var userToken = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        userToken = (UserDefaults.standard.object(forKey: "UserToken") as? String)!
        let url = URL(string: jsonURL)
        URLSession.shared.dataTask(with: url!) { (data,response,error) in
            
            
            do {
                self.coinsArray = try JSONDecoder().decode([Coin].self, from: data!)
                for eachCountry in self.coinsArray
                {
                    print(eachCountry.name)
                    print(eachCountry.price_usd)
                    
                }
                
                DispatchQueue.main.async {
                    
                    self.pickerView.reloadComponent(0)
                }
            }
            catch {
                print ("Error")
                
            }
            
            }.resume()
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinsArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinsArray[row].symbol
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let name = coinsArray[pickerView.selectedRow(inComponent: 0)].symbol
        
        txtCoinName.text = name
    }
    
    
    
    
    
    
    
    @IBAction func btnSaveCoin(_ sender: Any) {
        
        var coinName:String = ""
        var coinCurrency:String = ""
        var coinQuantity:Int = 0
        var coinPrice:Double = 0
        
        if (txtCoinName.text!.isEmpty) || (txtCurrency.text!.isEmpty) || (txtQuantity.text!.isEmpty) || (txtPrice.text!.isEmpty)
        {
            // Display alert message here
            //print("User name \(String(describing: email)) or password \(String(describing: password)) is empty")
            displayMessage(userMessage: "One of the required fields is missing")
            
            return
        }
        else{
            coinName = txtCoinName.text!
            coinCurrency = txtCurrency.text!
            coinQuantity = Int(txtQuantity.text!)!
            coinPrice = Double(txtPrice.text!)!
//            
//            CoreDataHandler.saveObject(token: userToken ,quantity: coinQuantity, price: coinPrice,member_id: 2,id:5,currency: coinCurrency, coin_name: coinName ,bought_on: "28-3-2018")
//            addcoin = CoreDataHandler.fetchObject()
            
            
            postRequestToServer()
           // self.displayMessage(userMessage: "Enter Successfully")
            txtCoinName.text! = ""
            txtCurrency.text! = ""
            txtQuantity.text! = ""
            txtPrice.text! = ""
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func postRequestToServer()
    {
        //let userID:String = (UserDefaults.standard.object(forKey: "UserID") as? String)!
        userToken = (UserDefaults.standard.object(forKey: "UserToken") as? String)!
        //print("http://34.212.213.221/ccmapi/public/api/ccm/addcoin/\(userID)")
        let myUrl = URL(string: "http://34.212.213.221/ccmapi/public/api/ccm/addcoin")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let postString = ["token": userToken ,  "coin_name": txtCoinName.text! , "quantity": txtQuantity.text! , "price":txtPrice.text! , "currency":txtCurrency.text! ] as [ String:String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print("*************error****************")
            print(error.localizedDescription)
            displayMessage(userMessage: "Something went wrong...")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print("error=\(String(describing: error))")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                
                if let parseJSON = json {
                    print(parseJSON)
                    
                    var JsonObject:Int = parseJSON["responseCode"] as? NSObject as! Int
                    print("\(JsonObject)**********************")
                    if JsonObject == 200
                    {
                         self.displayMessage(userMessage: "Enter Successfully")
                        //getting the user from response
                        let user = parseJSON.value(forKey: "response") as! NSDictionary
                        print(user)
                        
                        
                        
                        print("******* \(JsonObject)")
                    }
                    else if JsonObject == 401
                    {
                        
                        self.displayMessage(userMessage: "empty field")
                        
                        
                    }
                    else if JsonObject == 409
                    {
                        
                        self.displayMessage(userMessage: "Duplicate record")
                    }
                    else{
                        
                        
                        //                        DispatchQueue.main.async
                        //                            {
                        //                                if let tabbar = (self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as? UITabBarController) {
                        //                                    self.present(tabbar, animated: true, completion: nil)
                        //                                }
                        
                        // }
                        
                    }
                    
                }
                    
                    
                else {
                    //Display an Alert dialog with a friendly error message
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                }
                
            } catch {
                
                // Display an Alert dialog with a friendly error message
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                print("\(error)")
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
                            let ViewControllerForAddCoin = self.storyboard?.instantiateViewController(withIdentifier: "ViewControllerForAddCoin") as! ViewControllerForAddCoin
                            let appDelegate = UIApplication.shared.delegate
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
        }
    }
}
