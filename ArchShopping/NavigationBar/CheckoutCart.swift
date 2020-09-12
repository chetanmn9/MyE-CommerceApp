//
//  CheckoutCart.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 21/3/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import Foundation

struct Items: Codable, Equatable{
    var itemName: String
    var itemPrice: Float
    var itemQuantity: Int
    
    init?(json: Data) {
        if let newValue = try? JSONDecoder().decode(Items.self, from: json) {
            self = newValue
        } else {
            return nil
        }
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init(itemName: String, itemPrice: Float, itemQuantity: Int) {
        self.itemName = itemName
        self.itemPrice = itemPrice
        self.itemQuantity = itemQuantity
    }
}
