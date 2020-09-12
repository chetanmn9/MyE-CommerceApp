//
//  SignUpModel.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 14/6/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class signUpModel {
    
    //get the number of records in the master customer table, customer id is incremented by 1 to insert new customer record
    func getRecordsCount() -> Int{
        
        var count: Int?
        let container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
        if let countContext = container?.viewContext {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CustomerMaster")
            count = try? countContext.count(for: fetchRequest) //CustomerMaster.fetchRequest()) //{
        }
        return count!
    }
    
    //pass record count, username and password into database
    func updateCustomerMaster(count: Int, email: String, password: String) {
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let custMasterContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "CustomerMater")
        fetchRequest.predicate = NSPredicate(format: "username = %@", "*")
        
        //database table name
        let entity = NSEntityDescription.entity(forEntityName: "CustomerMaster", in: custMasterContext)
        let custMaster = NSManagedObject(entity: entity!, insertInto: custMasterContext)
        
        //set customerID(increment by 1), username and password
        custMaster.setValue((count + 1) as NSNumber, forKey: "cid")
        custMaster.setValue(email, forKey: "username")
        custMaster.setValue(password, forKey: "password")
        
        do {
            try custMasterContext.save()             //save into database
        }
        catch
        {
            print(error)
        }
        
    }
    
    //pass record count, firstname, lastname, email, mobile number and date of birth into database
    func updateCustomerDetails(count: Int, firstName: String, lastName: String, eMail: String, mobile: String, dob: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let custDetailsContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "CustomerDetail")
        fetchRequest.predicate = NSPredicate(format: "fName = %@", "c")
        
        let entity = NSEntityDescription.entity(forEntityName: "CustomerDetail", in: custDetailsContext)
        
        //set customerID(increment by 1), firstname, lastname, email, mobile number and date of birth into database
        let custDetails = NSManagedObject(entity: entity!, insertInto: custDetailsContext)
        custDetails.setValue((count + 1) as NSNumber, forKey: "cid")
        custDetails.setValue(firstName, forKey: "fname")
        custDetails.setValue(lastName, forKey: "lname")
        custDetails.setValue(eMail, forKey: "email")
        custDetails.setValue(mobile, forKey: "mobile")
        var birthDate = ""
        if dob.isEmpty {
            birthDate = "Not provided"
        } else {
            birthDate = dob
        }
        
        custDetails.setValue(birthDate, forKey: "dob")
        do {
            try custDetailsContext.save()                   //save into database
        }
        catch
        {
            print(error)
        }
        
    }
}
