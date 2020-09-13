//
//  LocationModel.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 12/5/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import Foundation
import UIKit

class LocationModel: NSObject {

    //database table attributes
    
    var storeID: String?
    var storeName: String?
    var storeAddress: String?
    var storeLongitude: String?
    var storeLatitude: String?
    
    override init()
    {
        
    }
    
    init(storeID: String, storeName: String, storeAddress: String, storeLatitude: String, storeLongitude: String) {
        
        self.storeID = storeID
        self.storeName = storeName
        self.storeAddress = storeAddress
        self.storeLatitude = storeLatitude
        self.storeLongitude = storeLongitude
        
    }
    
    override var description: String {
        return "StoreID: \(String(describing: storeID)), Name: \(String(describing: storeName)), Address: \(String(describing: storeAddress)), Latitude: \(String(describing: storeLatitude)), Longitude: \(String(describing: storeLongitude))"
    }
    
}
