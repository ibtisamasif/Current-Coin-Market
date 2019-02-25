//
//  DeleteViewController.swift
//  FirstVersion
//
//  Created by Touqeer Ahmad on 4/2/18.
//  Copyright © 2018 Touqeer Ahmad. All rights reserved.
//

import UIKit

class DeleteViewController: UIViewController {

    @IBOutlet weak var txtId: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnDelete(_ sender: Any) {
  
        var id:String = txtId.text!

        //Send HTTP Request to perform Sign in
        let myUrl = URL(string: "http://34.212.213.221/ccmapi/public/api/ccm/delete_coin/\(id)")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "DELETE"// Compose a query string
        request.addValue("application/json", forHTTPHeaderField: "content-type")
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
                
                if let parseJSON = json {
                    print(parseJSON)
                    
                    var JsonObject:Int = parseJSON["responseCode"] as? NSObject as! Int
                    
                    if JsonObject == 200
                    {
                        //getting the user from response
                        let user = parseJSON.value(forKey: "response") as! NSDictionary
//
                        print(user)

                        print("******* \(JsonObject)")
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
