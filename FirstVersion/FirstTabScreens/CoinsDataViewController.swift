//
//  FirstViewController.swift
//  FirstVersion
//
//  Created by Touqeer Ahmad on 2/12/18.
//  Copyright © 2018 Touqeer Ahmad. All rights reserved.
//

import UIKit
struct Country : Decodable {
    
    var name : String
    var symbol : String
    var rank : String
    var price_usd : String
    
}

class CoinsDataViewController: UIViewController , UITableViewDataSource ,UITableViewDelegate{
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var UItableView: UITableView!
    private var jsonURL = "https://api.coinmarketcap.com/v1/ticker/?start=0&limit=200"
    var countries = [Country]()
    override func viewDidLoad() {
        super.viewDidLoad()
       // fetchWeatherData()
    }
    override func viewWillAppear(_ animated: Bool) {
         fetchWeatherData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:  Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CoinCell = tableView.dequeueReusableCell(withIdentifier: "CoinCell", for: indexPath) as! CoinCellLables
        CoinCell.selectionStyle = .none
        CoinCell.lbCoinName.textColor = UIColor.gray
        CoinCell.lbCoinName.text = "\(self.countries[indexPath.row].name)"
        CoinCell.lbCoinSymbol.text = "\(self.countries[indexPath.row].symbol)"
        CoinCell.lbCoinRank.text = "\(self.countries[indexPath.row].rank)"
        CoinCell.lbCoinPriceUsd.text = "\(self.countries[indexPath.row].price_usd)"
        // lbCoinName.textColor = UIColor.red
        return CoinCell
    }
    
    private func fetchWeatherData() {
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
                self.countries = try JSONDecoder().decode([Country].self, from: data!)
                for eachCountry in self.countries
                {
                    print(eachCountry.name)
                    
                }
                
                DispatchQueue.main.async {
                    self.UItableView.reloadData()
                }
            }
            catch {
                print ("Error")
                self.displayMessage(userMessage: "Error on server side please try again")

            }
            
            }.resume()
    }
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
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
}

