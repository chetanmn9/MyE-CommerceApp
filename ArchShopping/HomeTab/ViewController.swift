//
//  ViewController.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 20/2/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var firstName = "Customer"
    var naviBar = NavBar()   //call the navigation bar
    
    //Get customer firstname on sign up or login
    @objc func sendFirstNameToViewController(notification:NSNotification){
        let userInfo = notification.userInfo as! Dictionary<String,String>
        firstName = userInfo["value"]!
        welcomeNote.text = "Hi "+firstName+", Welcome to My Mart."
    }
    
    //did set property  - view gets updated with customer firstname
    @IBOutlet weak var welcomeNote: UILabel! {
        didSet {
            welcomeNote.text = "Hi "+firstName+", Welcome to My Mart."
        }
    }
    
    @IBOutlet weak var logInButton: UIButton!           //login button
    @IBOutlet weak var signUpButton: UIButton!          //sign up button
    
    @IBOutlet weak var signOut: UIButton!               //Sign out button
    
    //Segue to sign up screen
    @IBAction func signUp(_ sender: Any) {
        self.performSegue(withIdentifier: "Present Sign Up Screen", sender: self)
    }
    
    //set user default to false on log out
    @IBAction func signOut(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
    
    //Segue to checkout screen on tapping the cart button in the navigation bar
    @objc func goToCheckout(sender: UIButton!) {
        self.performSegue(withIdentifier: "show check out", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //customer login and sign up view observer
        NotificationCenter.default.addObserver(self, selector: #selector(setupView), name: NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil)
        
        //Customer name update observer on login/sign up
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(sendFirstNameToViewController(notification:)), name: NSNotification.Name(rawValue: "firstName"), object: nil)
        
        //call nvigation bar
        naviBar.navigationBar(self)
        
        //maintain home screen login/sign up/sign out view
        setupView()
        
        //Assign data source and delegate to self
        promoCollectionView.dataSource = self
        promoCollectionView.delegate = self
        
    }
    
    //these are the current promotion names running for this e-commerce org(this can be maitaned in database and sourced as a JSON)
    var promoList = ["10% Off First 50 Customers","Its Raining Deals!","Our Geeks can fix it!","Partner with us","Spring Sale!","Tech Bonanza","Hit the like button","Free Delivery!","Join the Club","We are in this together","Customer First.","Join out team","New Clothing Range","Gratude Program, Apply now!","Its Raining Deals!","Our Geeks can fix it!","Partner with us","Spring Sale!","Tech Bonanza","Hit the like button","Free Delivery!","Join the Club"]
    
    
    //Below property are used for animation counter to display number of viewing a promotion
    private var maxCount: Int?
    private var currentCount: Int?
    private var updateTimer: Timer?
    
    
    @IBOutlet weak var promoCollectionView: UICollectionView!
    
    //Number of sections in this collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Number of items in each section(promo count)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return promoList.count
    }
    
    //resue the collection view cells as they are scrolled
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromoCell", for: indexPath)
        
        if let promoCell = cell as? PromoCollectionViewCell {
            
            promoCell.image.contentMode = UIView.ContentMode.scaleAspectFit
            promoCell.image.clipsToBounds = true
            
            //promo names
            promoCell.promoName.text = promoList[indexPath.row]
            
            //promo images get assigned
            promoCell.image.image = UIImage(named: promoList[indexPath.row])
            
            //resize the images
            let newImage = self.resizeImage(image: promoCell.image.image!, targetSize: collectionView.frame.size)
            promoCell.image.image = newImage
            
        }
        
        cell.layer.cornerRadius = 10
        return cell
    }
    
    //Number of customers viewing the current promotion starts count animating as it comes into the view
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in promoCollectionView.visibleCells {
            
            if let promoCell = cell as? PromoCollectionViewCell{
                promoCell.noViewing.text = String(0)
                promoCell.countViewers(fromValue: 0,toValue: 500)
            }
        }
    }
    
    //resize image
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        
        let widthRatio  = targetSize.width - 10
        let heightRatio = (targetSize.height / 2) - 10
        
        var newSize: CGSize
        
        newSize = CGSize(width: widthRatio, height: heightRatio)
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    //maintain home screen login/sign up/sign out view
    @objc func setupView() {
        
        self.logInButton?.layer.cornerRadius = 10
        self.logInButton?.clipsToBounds = true
        
        self.signUpButton?.layer.cornerRadius = 10
        self.signUpButton?.clipsToBounds = true
        
        self.signOut?.layer.cornerRadius = 10
        self.signOut?.clipsToBounds = true
        
        let loginStatus = loginCheck()
        
        if loginStatus.isLoggedIn() == true {
            welcomeNote?.isHidden = false
            welcomeNote?.isEnabled = true
            signOut?.isHidden = false
            signOut?.isEnabled = true
            logInButton?.isHidden = true
            logInButton?.isEnabled = false
            signUpButton?.isHidden = true
            signUpButton?.isEnabled = false
        } else {
            welcomeNote?.isHidden = true
            welcomeNote?.isEnabled = false
            signOut?.isHidden = true
            signOut?.isEnabled = false
            logInButton?.isHidden = false
            logInButton?.isEnabled = true
            signUpButton?.isHidden = false
            signUpButton?.isEnabled = true
        }
        
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

