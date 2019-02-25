//
//  SecondViewController.swift
//  FirstVersion
//
//  Created by Touqeer Ahmad on 2/12/18.
//  Copyright © 2018 Touqeer Ahmad. All rights reserved.
//

import UIKit
struct CountryPair : Decodable {
    
    var symbol : String
    var price_btc : String
    var price_usd : String
    var percent_change_1h : String
    var percent_change_24h : String
    var name : String
    
}

class PairsCoinsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet var UIPairTable: UITableView!
    private var jsonURL = "https://api.coinmarketcap.com/v1/ticker/?start=0&limit=200"
    var countries = [CountryPair]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        
        let url = URL(string: jsonURL)
        URLSession.shared.dataTask(with: url!) { (data,response,error) in
            
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            do {
                self.countries = try JSONDecoder().decode([CountryPair].self, from: data!)
                for eachCountry in self.countries
                {
                    print(eachCountry.symbol)
                    
                }
                
                DispatchQueue.main.async {
                    self.UIPairTable.reloadData()
                }
            }
            catch {
                print ("Error")
                self.displayMessage(userMessage: "Error on server side please try again")

            }
            
            }.resume()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.countries.count)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let CoinCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PairCellLables
        CoinCell.selectionStyle = .none
        if  Double("\(self.countries[indexPath.row].percent_change_1h)")! > 0
        {
            
            CoinCell.lbPercent1H.textColor = UIColor.green
            CoinCell.lbPercent1H.text = "\(self.countries[indexPath.row].percent_change_1h)"
            
        }
        else
        {
            CoinCell.lbPercent1H.textColor = UIColor.red
            CoinCell.lbPercent1H.text = "\(self.countries[indexPath.row].percent_change_1h)"
            
        }
        if  Double("\(self.countries[indexPath.row].percent_change_24h)")! > 0
        {
            
            CoinCell.lbPercent24h.textColor = UIColor.green
            CoinCell.lbPercent24h.text = "\(self.countries[indexPath.row].percent_change_24h)"
            
        }
        else
        {
            CoinCell.lbPercent24h.textColor = UIColor.red
            CoinCell.lbPercent24h.text = "\(self.countries[indexPath.row].percent_change_24h)"
            
        }
        CoinCell.lbPriceBtc.text = "\(self.countries[indexPath.row].price_btc)"
        CoinCell.lbPriceUsd.text = "\(self.countries[indexPath.row].name)"
        return CoinCell
        
        
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

