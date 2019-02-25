//
//  ForthViewController.swift
//  FirstVersion
//
//  Created by Touqeer Ahmad on 2/13/18.
//  Copyright © 2018 Touqeer Ahmad. All rights reserved.
//

import UIKit

class NewsReadViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var UITable: UITableView!
    
    var articles: [Article]? = []
    var myIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticles()
    }
    func fetchArticles(){
        
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?sources=crypto-coins-news&apiKey=81fc14c016e8464d8a1ef37ef1db0e90")!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            if error != nil {
                print(error!)
                return
            }
            
            self.articles = [Article]()
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let articlesFromJson = json["articles"] as? [[String : AnyObject]] {
                    for articleFromJson in articlesFromJson {
                        let article = Article()
                        if let title = articleFromJson["title"] as? String,  let desc = articleFromJson["description"] as? String
                            , let url = articleFromJson["url"] as? String ,let urlToImage = articleFromJson["urlToImage"] as? String
                            // let author = articleFromJson["author"] as? String,
                        {
                            
                            //article.author = author
                            article.desc = desc
                            article.headline = title
                            article.url = url
                            article.urlToImage = urlToImage
                        }
                        self.articles?.append(article)
                    }
                }
                DispatchQueue.main.async {
                    self.UITable.reloadData()
                }
                
            } catch let error {
                print(error)
            }
            
            
        }
        
        task.resume()
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        cell.selectionStyle = .none
        cell.title.text = self.articles?[indexPath.item].headline
        cell.desc.text = self.articles?[indexPath.item].desc
        cell.author.text = self.articles?[indexPath.item].urlToImage
        cell.imgView.downloadImage(from: (self.articles?[indexPath.item].urlToImage!)!)
        cell.imgView.layer.cornerRadius = cell.imgView.frame.height/2
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _  = indexPath.row
        performSegue(withIdentifier: "showDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WebNewsViewController {
            destination.articale = articles?[(UITable.indexPathForSelectedRow?.row)!]
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

extension UIImageView {
    
    func downloadImage(from url: String){
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            if error != nil {
                print(error ?? " empty " )
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

