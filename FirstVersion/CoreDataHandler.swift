//
//  CoreDataHandler.swift
//  FirstVersion
//
//  Created by Touqeer Ahmad on 3/28/18.
//  Copyright © 2018 Touqeer Ahmad. All rights reserved.
//

import UIKit
import CoreData
class CoreDataHandler: NSObject {
    
    
    private class func getContext() -> NSManagedObjectContext
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return  appDelegate.persistentContainer.viewContext
    }
    
    
    class func saveObject(token:String ,quantity:Int , price:Double , member_id:Int , id:Int , currency:String , coin_name:String , bought_on:String) -> Bool{
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "AddCoin" , in: context)
        let manageObject = NSManagedObject(entity: entity! , insertInto: context)
        manageObject.setValue(token, forKey: "token")
        manageObject.setValue(quantity, forKey: "quantity")
        manageObject.setValue(price, forKey: "price")
        manageObject.setValue(member_id, forKey: "member_id")
        manageObject.setValue(id, forKey: "id")
        manageObject.setValue(currency, forKey: "currency")
        manageObject.setValue(coin_name, forKey: "coin_name")
        manageObject.setValue(bought_on, forKey: "bought_on")
        
        do{
            
            try context.save()
            return true
            
        }
        catch{
            
            return false
        }
        
    }
    
    class func fetchObject() -> [AddCoin]? {
        
        let context = getContext()
        var addcoin:[AddCoin]? = nil
        
        do{
            
            addcoin = try context.fetch(AddCoin.fetchRequest())
            return addcoin
            
        }catch{
            return addcoin
        }
        
    }
    class func cleanDelete() -> Bool {
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: AddCoin.fetchRequest())
        
        do {
            try context.execute(delete)
            return true
        }catch {
            return false
        }
    }
    class func deleteObject(user: AddCoin) -> Bool {
        
        let context = getContext()
        context.delete(user)
        
        do{
            try context.save()
            return true
        }
        catch{
            
            return false
        }
    }
    
    
    
    
}
