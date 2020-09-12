	//
//  storelocation.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 12/5/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import Foundation
import UIKit
    
protocol StoreProtocol: class {
    func itemsDownloaded(items: NSArray)
}
    
class StoreLocation: NSObject {
        
    weak var delegate: StoreProtocol!
    
    let urlPath = "http://ec2-13-210-223-47.ap-southeast-2.compute.amazonaws.com/service.php"
    //"http://ec2-3-25-76-168.ap-southeast-2.compute.amazonaws.com/service.php"
    //http://ec2-13-238-254-148.ap-southeast-2.compute.amazonaws.com/service.php"
    //"http://ec2-13-54-90-33.ap-southeast-2.compute.amazonaws.com/service.php"
    
    func downloadedItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, responds, error) in
            
            if error != nil {
                print("failed to download data")
            } else {
                print("Data Downloaded")
                self.parseJSON(data!)
            }
    }
        task.resume()
}

    func parseJSON(_ data: Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let location = LocationModel()
        
            if let storeID = jsonElement["zstore_id"] as? String,
                let storeName = jsonElement["zstore_name"] as? String,
                let storeAddress = jsonElement["zstore_address"] as? String,
                let storeLatitude = jsonElement["zstore_latitude"] as? String,
                let storeLongitude = jsonElement["zstore_longitude"] as? String
            {
                location.storeID = storeID
                location.storeName = storeName
                location.storeAddress = storeAddress
                location.storeLongitude = storeLongitude
                location.storeLatitude = storeLatitude
            }
            
            locations.add(location)
    }
    DispatchQueue.main.async(execute: { () -> Void in
        
        self.delegate.itemsDownloaded(items: locations)
        
    })
    }
}
