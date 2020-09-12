//
//  NavigationController.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 11/4/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import Foundation
import UIKit

class NavBar {
    
    func navigationBar(_ vc: UIViewController) {
        if let navigationBar = vc.navigationController?.navigationBar {
     
                    vc.navigationItem.title = "MY MART"          //companyNameLabel.text
                    vc.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font :UIFont(name: "HelveticaNeue-Bold" , size: 20)!]


                    
                    
                    let searchButton = UIButton()
                    searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
                    searchButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    searchButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                    let searchBarButton = UIBarButtonItem(customView: searchButton)
                    
                    let cartButton = UIButton()
                    cartButton.setImage(UIImage(systemName: "cart.fill"), for: .normal)
                    cartButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    cartButton.addTarget(vc, action: #selector(self.goToCheckout), for: .touchUpInside)
                    cartButton.frame = CGRect(x: 0 , y: 0, width: 40, height: 40)
                    let cartBarButton = UIBarButtonItem(customView: cartButton)
                    
                   
                    let lhsButton = UIButton()
                    if vc is ArchShopping.ProductDetailsTableViewController {
                        lhsButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
                    } else {
                        lhsButton.setImage(UIImage(systemName: "list.dash"), for: .normal)
                    }
                    lhsButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    lhsButton.addTarget(vc, action: #selector(self.backToCategory), for: .touchUpInside)
                    lhsButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                    
                    let listBarButton = UIBarButtonItem(customView: lhsButton)
                    
                    vc.navigationItem.rightBarButtonItems = [cartBarButton, searchBarButton]
                    vc.navigationItem.leftBarButtonItem = listBarButton
                    
                    navigationBar.addSubview(searchButton)
                    navigationBar.addSubview(cartButton)
                    navigationBar.addSubview(lhsButton)
                    navigationBar.backgroundColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
                    navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
            
                    
                }
        
                
    }
    
    @objc func backToCategory(sender: UIButton!) {
        print("back Button tapped")
    }
    
    @objc func goToCheckout(sender: UIButton!) {
        print("cart Button tapped")
    }
}
