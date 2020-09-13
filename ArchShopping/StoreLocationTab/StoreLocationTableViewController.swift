//
//  StoreLocationTableViewController.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 12/5/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
// 

import UIKit

class StoreLocationTableViewController: UITableViewController, StoreProtocol {
    
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        self.tableView.reloadData()
    }
    
    var naviBar = NavBar()
    var feedItems: NSArray = NSArray()
    var selectedLocation : LocationModel = LocationModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        naviBar.navigationBar(self)
        tableView.delegate = self
        tableView.dataSource = self

        let storeLocation = StoreLocation()
        storeLocation.delegate = self
        storeLocation.downloadedItems()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath)
        let item: LocationModel = feedItems[indexPath.row] as! LocationModel
        cell.textLabel!.text = item.storeAddress

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedLocation = feedItems[indexPath.row] as! LocationModel
        self.performSegue(withIdentifier: "mapSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get reference to the destination view controller
        if segue.identifier == "mapSegue" {
            let navVC = segue.destination as! UINavigationController
                let detailVC = navVC.topViewController as! StoreMapLocatorViewController
                    detailVC.selectedLocation = selectedLocation                
            
        }
    }

}
