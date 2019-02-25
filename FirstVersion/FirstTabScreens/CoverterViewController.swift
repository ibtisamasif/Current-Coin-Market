//
//  ThirdViewController.swift
//  FirstVersion
//
//  Created by Touqeer Ahmad on 2/14/18.
//  Copyright © 2018 Touqeer Ahmad. All rights reserved.
//
struct Coins : Decodable {
    
    var name : String
    var symbol : String
    var rank : String
    var price_usd : String
    
}

import UIKit
import Foundation
class CoverterViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    @IBOutlet weak var lbRight: UILabel!
    @IBOutlet weak var lbLeft: UILabel!
    @IBOutlet weak var tvRight: UITextField!
    @IBOutlet weak var tvLeft: UITextField!
    @IBOutlet weak var pvCoins: UIPickerView!
    var finalPriceCoverted:Double = 0.0
    var myCurrency:[String] = []
    var myValues:[Double] = []
    var convertIntoInt = 0.0
    var syb = ""
    var activeCurrency:Double = 0;
    
    private var jsonURL = "https://api.coinmarketcap.com/v1/ticker/?start=0&limit=200"
    var coinsArray = [Coins]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        print("hight")
        let url = URL(string: jsonURL)
        URLSession.shared.dataTask(with: url!) { (data,response,error) in
            
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            do {
                self.coinsArray = try JSONDecoder().decode([Coins].self, from: data!)
                for eachCountry in self.coinsArray
                {
                    print(eachCountry.name)
                    print(eachCountry.price_usd)
                    
                }
                
                DispatchQueue.main.async {
                    self.pvCoins.reloadComponent(0)
                    self.pvCoins.reloadComponent(1)
                }
            }
            catch {
                print ("Error")
                
            }
            
            }.resume()
        
        let url1 = URL(string: "http://api.fixer.io/latest")
        
        let task1 = URLSession.shared.dataTask(with: url1!) { (data, response, error) in
            
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            if error != nil
            {
                print ("ERROR")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let rates = myJson["rates"] as? NSDictionary
                            
                        {
                            
                            self.myCurrency.append(("PKR"))
                            self.myValues.append((110.49))
                            for (key, value) in rates
                            {
                                print("dfsffsfsffsgersgs")
                                self.myCurrency.append((key as? String)!)
                                self.myValues.append((value as? Double)!)
                            }
                        }
                    }
                    catch
                    {
                        
                    }
                }
            }
        }
        task1.resume()
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 2
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        
        if component == 0 {
            return coinsArray.count
        }
        else{
            return myCurrency.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        
        if component == 0 {
            return coinsArray[row].name
        }
        else{
            return myCurrency[row]
        }
        
    }
    
    @IBAction func editing_change(_ sender: Any) {
        
        var q:Double
        q = 1
        
        if (Double(tvRight.text!) == nil)
        {
            
        }else
        {
            q = Double(tvRight.text!)!
            
            let ro = round(q / finalPriceCoverted)
            self.tvLeft.text = "\(ro)"
        }
    }
    
    @IBAction func editingLeftSide(_ sender: Any) {
        
        var q:Double
        q = 1
        
        if (Double(tvLeft.text!) == nil)
        {
            
        }else
        {
            q = Double(tvLeft.text!)!
            
            let rou = round(finalPriceCoverted * q)
            self.tvRight.text = "\(rou)"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let name = coinsArray[pickerView.selectedRow(inComponent: 0)].name
        let priceCurrency = myCurrency[pickerView.selectedRow(inComponent: 1)]
        if component == 0 {
            convertIntoInt = Double(self.coinsArray[row].price_usd)!
            syb = "\(self.coinsArray[row].symbol)"
        }else {
            
            let dollerIntoPKR:Double = myValues[row]
            finalPriceCoverted = convertIntoInt * dollerIntoPKR
            print("\(convertIntoInt) \(dollerIntoPKR) \(finalPriceCoverted)")
        }
        
        let roundedPrice = round(finalPriceCoverted)
        self.tvRight.text = " \(roundedPrice) "
        self.tvLeft.text = " \(1) "
        let divid = 1 / roundedPrice
        let rounded = round(divid)
        self.lbRight.text = "1:\(priceCurrency)=\(rounded) \(syb)"
        self.lbLeft.text = "1:\(syb)=\(roundedPrice)\(priceCurrency)"
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

