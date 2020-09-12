//
//  SignUpViewController.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 21/2/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    //Dimiss the Sign Up view - A cancel button at top right
    @IBAction func close(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
    }
    
    @IBOutlet weak var fNameText: UITextField! { didSet { fNameText.delegate = self } }       //Customer First Name
    @IBOutlet weak var lNameText: UITextField! { didSet { lNameText.delegate = self } }       //Customer Last Name
    @IBOutlet weak var eMail: UITextField! { didSet { eMail.delegate = self } }               //Customer email id
    @IBOutlet weak var password: UITextField! { didSet { password.delegate = self } }         //Customer Password
    @IBOutlet weak var mobile: UITextField! { didSet { mobile.delegate = self } }             //Customer mobile number
    @IBOutlet weak var dob: UITextField!{ didSet { dob.delegate = self } }                    //Customer Date of Birth
    
    //Label for the above fields
    @IBOutlet weak var fNameValid: UILabel!
    @IBOutlet weak var lNameValid: UILabel!
    @IBOutlet weak var emailValid: UILabel!
    @IBOutlet weak var passwordValid: UILabel!
    @IBOutlet weak var mobileValid: UILabel!
    
    //Sign up button action - validate and store customer details in core data
    @IBAction func signUp(_ sender: Any) {
        
        // Implematation of user defaults to maintain customer login status
        let signUp = signUpModel()
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        
        fNameValid.isHidden = true
        lNameValid.isHidden = true
        emailValid.isHidden = true
        mobileValid.isHidden = true
        passwordValid.isHidden = true
        
        let validate = validator()
        
        //Each Customer field is validated - if it fails validation, the error message come out of hiding
        if validate.isTextNotEmpty(fNameText.text!) == false {
            fNameValid.isHidden = false
        }
        if validate.isTextNotEmpty(lNameText.text!) == false {
            lNameValid.isHidden = false
        }
        
        if validate.isEmailValid(eMail.text!) == false {
            emailValid.isHidden = false
        }
        
        if validate.isEmailAvailable(eMail.text!) == false {
            emailValid.text = "user already exist"
            emailValid.isHidden = false
        }
        
        if validate.isMobileNumber(mobile.text!) == false {
            mobileValid.isHidden = false
        }
        
        if validate.isPasswordValid(password.text!) == false {
            passwordValid.isHidden = false
        }
        
        //If all fields are validated
        if fNameValid.isHidden == true, lNameValid.isHidden == true, emailValid.isHidden == true, mobileValid.isHidden == true, passwordValid.isHidden == true {
            
            let count = signUp.getRecordsCount()
            //Update Customer Master table with CustomerID, Email(Username) and Password
            signUp.updateCustomerMaster(count: count, email: eMail.text!, password: password.text!)
            
            //Update Customer Details table with CustomerID, First Name, Last Name, Email, Mobile and Date of Birth
            signUp.updateCustomerDetails(count: count, firstName: fNameText.text!, lastName: lNameText.text!, eMail: eMail.text!, mobile: mobile.text!, dob: dob.text!)
            
            //Set user default to logged in after sign up
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            UserDefaults.standard.synchronize()
            
            //Notification to View controller on successfull sign in to welcome customer on home sreen
            let nc = NotificationCenter.default
            nc.post(name: NSNotification.Name(rawValue: "firstName"), object: nil, userInfo: ["value" : fNameText.text!])
            
            //dismiss after sign up
            presentingViewController?.dismiss(animated: true)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil)
            
        }
    }
    
    
    var resignationHandler: (() -> Void)?
    
    //Resign keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
        resignationHandler?()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //Date picker for Customer Date of birth
    private var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //On view did load ensure the date picker is initialized for date picking
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(SignUpViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        dob.inputView = datePicker
        
    }
    
    //Tappinf outside of the textfield resigns the keyboard
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //On picking the date, it gets assigned to the field that is set to insert into database and then resigns the date picker
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dob.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
}
