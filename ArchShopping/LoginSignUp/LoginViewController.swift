//
//  LoginViewController.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 21/2/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var username: UITextField!     //text file to enter username(email)
    @IBOutlet weak var password: UITextField!     //text file to enter password
    
    //Dimiss the Sign Up view - A cancel button at top right
    @IBAction func close(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
    }
    
    //Property to pass customer first name to welcome screen
    var firstName: String?
    
    @IBAction func login(_ sender: Any) {
        
        let validate = validator()      //validator instance
        let login = loginModel()        //login instance
        
        //if validated that username and password are not empty
        if validate.isTextNotEmpty(username.text!) == true, validate.isTextNotEmpty(password.text!) == true {
            
            let cid = login.authenticateCustomer(username: username.text!,password: password.text!)  //pass username and password to authentication method, fetch customer ID
            
            if cid == 0 {   //alert of unsuccessfull login
                let loginFailAlert = UIAlertController(title: "Login Fail!", message: "Username and Password Do not Match!", preferredStyle: .alert)
                loginFailAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(loginFailAlert, animated: true, completion: nil)
            } else {     //Successful login
                let fName = login.getCustomerDetails(cid: cid)      //fetch customer details based on customer ID
                firstName = fName
                
                //Notification to View controller on successfull sign in to welcome customer on home sreen
                let nc = NotificationCenter.default
                nc.post(name: NSNotification.Name(rawValue: "firstName"), object: nil, userInfo: ["value" : fName])
                
                //dismiss after sign up
                presentingViewController?.dismiss(animated: true)
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
}
