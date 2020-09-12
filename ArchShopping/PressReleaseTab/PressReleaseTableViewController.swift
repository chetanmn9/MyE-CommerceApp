//
//  PressReleaseTableViewController.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 25/5/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class PressReleaseTableViewController: UITableViewController {
    
    var naviBar = NavBar()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var releaseHeader = [(image: String, header: String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        naviBar.navigationBar(self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        
        let semaphores = DispatchSemaphore(value: 0)
        let db = Firestore.firestore()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"    //'T'HH:mm:ssZ"
        
        db.collection("Press Release").getDocuments() {(documentSnapshot,error) in
            if error == nil && documentSnapshot != nil {
                self.activityIndicator.startAnimating()
                for document in documentSnapshot!.documents {
                    let documentData = document.data()
                    self.releaseHeader.append((image: documentData["ReleaseImages"]! as? String ?? "No Image", header: documentData["ReleaseHeader"]! as? String ?? "No Headline"))
                }
                
                semaphores.signal()
                self.activityIndicator.hidesWhenStopped = true
            }
            semaphores.wait()
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        releaseHeader.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PressReleaseCell", for: indexPath)
        
        let pressReleaseCell = cell as? PressReleaseTableViewCell
        
        pressReleaseCell?.pressImage.image = UIImage(named: releaseHeader[indexPath.row].image)
        
        pressReleaseCell?.pressHeadline.text = releaseHeader[indexPath.row].header
        
        pressReleaseCell?.pressHeadline.lineBreakMode = NSLineBreakMode.byWordWrapping
        pressReleaseCell?.pressHeadline.numberOfLines = 0
        pressReleaseCell?.pressHeadline.sizeToFit()
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.layer.shadowOpacity = 0.5
        cell.clipsToBounds = true
        
        return cell
    }
}
