//
//  validator.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 24/2/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class validator {
    
    //Email Validator using regular expressions(must have @ and .)
    func isEmailValid(_ value: String) -> Bool {
        
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                return false
            }
        } catch {
            return false
        }
        return true
    }
    
    //Check if the textfield is empty
    func isTextNotEmpty(_ value: String) -> Bool {
        if value == "" {
            return false
        }
        return true
    }
    
    //Mobile number must be 10 digits
    func isMobileNumber(_ value: String) -> Bool {
        do {
            if try NSRegularExpression(pattern: "^[0-9]{10}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                return false
            }
        } catch {
            return false
        }
        return true
    }
    
    //Password must be between 8-10 characters, atleast 1 Capitalized, atleast 1 number and atleast 1 special character
    func isPasswordValid(_ value: String) -> Bool {
        do {
            if try NSRegularExpression(pattern: "^(?=.*[A-Z].*[a-z])(?=.*[!@#$&*]).{8,10}$").firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                return false
            }
        } catch {
            return false
        }
        return true
    }
    
    //check if any other customer in the database with the same username
    func isEmailAvailable(_ value: String) -> Bool {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        
        let custMasterEmailContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "CustomerMaster")
        fetchRequest.predicate = NSPredicate(format: "username = %@", value)
        
        do {
            let result = try custMasterEmailContext.fetch(fetchRequest)
            if result.count > 0 {
                return false
            }
        } catch {
            return false
        }
        return true
    }
}
