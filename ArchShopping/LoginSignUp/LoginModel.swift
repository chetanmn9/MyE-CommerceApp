//
//  Login.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 14/6/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class loginModel {
    
    func authenticateCustomer(username: String, password: String) -> Int {
        
        var cid = 0
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return 2 }
        
        let custMasterAuthContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "CustomerMaster")
        fetchRequest.predicate = NSPredicate(format: "username = %@", username)
        
        //Core Data fetch customer details
        do {
            let result = try custMasterAuthContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                if (data.value(forKey: "username") as! String) == username {
                    if (data.value(forKey: "password") as! String) == password {
                        cid = (data.value(forKey: "cid") as! Int)
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        UserDefaults.standard.synchronize()
                    }
                }
            }
            
        } catch {
            print("Failed")
            return 0
        }
        return cid
    }
    
    //fetch customer details based in customer id
    func getCustomerDetails(cid: Int) -> String {
        
        var fName: String?
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return "fail" }
        
        let custDetailsContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "CustomerDetail")
        fetchRequest.predicate = NSPredicate(format: "cid = %d", cid)
        
        //get customer first name after authentication
        do {
            let result = try custDetailsContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                fName = (data.value(forKey: "fname") as! String)
            }
            
        } catch {
            print("Failed")
        }
        return fName!    //return firstname
    }
    
    
    
}
