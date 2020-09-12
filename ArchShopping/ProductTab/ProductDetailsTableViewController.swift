//
//  ProductDetailsTableViewController.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 9/3/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import UIKit
import GMStepper


class ProductDetailsTableViewController: UITableViewController, cellSelectDelegate {
    
    //call the navigation bar
    var naviBar = NavBar()
    
    func addToCart(_ tag: Int,_ qty: Double,_ product: String,_ productPrice: Float) {      
        
        var cartItem: Items? {
            get {
                return Items(itemName: product, itemPrice: productPrice, itemQuantity: Int(qty))
            }
        }
 
        var readCartItems = Items(itemName: "", itemPrice: 0.0, itemQuantity: 0)
        var compressCartItem = Items(itemName: "", itemPrice: 0.0, itemQuantity: 0)
        
        var cartItems: [Items] = [Items(itemName: cartItem!.itemName, itemPrice: cartItem!.itemPrice, itemQuantity: cartItem!.itemQuantity)]
        
        var finalCartItems: [Items] = [Items(itemName: "", itemPrice: 0.0, itemQuantity: 0)]
        finalCartItems.remove(at: 0)
        
        //Retrive the cart as a UIBrowserDocument(JSON File) on the customers files system
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ).appendingPathComponent("untitles.json") {        //File Name
            let jsonReadData = try? Data(contentsOf: url)
            if let jsonReadData = jsonReadData {
                let parsedItems = try? JSONSerialization.jsonObject(with: jsonReadData, options: .mutableContainers)
                let items = parsedItems as! [[String:AnyObject]]
                
                for item in items {
                    
                    guard let itemName = item["itemName"]  as? String else { continue }
                    guard let itemPrice = item["itemPrice"] as? Float else { continue }
                    guard let itemQuantity = item["itemQuantity"] as? Int else { continue }
                    
                    readCartItems.itemName = itemName
                    readCartItems.itemPrice = itemPrice
                    readCartItems.itemQuantity = itemQuantity
                    cartItems.append(readCartItems)
                }
                
                for items in cartItems {
                    let duplicateItems = cartItems.filter{ $0.itemName.contains(items.itemName) }
                    var qty: Int = 0
                    for items in duplicateItems {
                        qty = qty + items.itemQuantity
                        compressCartItem.itemName = items.itemName
                        compressCartItem.itemPrice = items.itemPrice
                        compressCartItem.itemQuantity = qty
                    }
                    finalCartItems.append(compressCartItem)
                }
                finalCartItems.removeDuplicates()
            }
        }
        
        var allItems: [AnyObject] = []
        for items in finalCartItems {
            var itemDict: [String : AnyObject] = [:]
            itemDict["itemName"] = items.itemName as AnyObject
            itemDict["itemPrice"] = items.itemPrice as AnyObject
            itemDict["itemQuantity"] = items.itemQuantity as AnyObject
            allItems.append(itemDict as AnyObject)
        }
        
        //Save the cart as a UIBrowserDocument(JSON File) on the customers files system
        let jsonData = try? JSONSerialization.data(withJSONObject: allItems, options: .prettyPrinted)
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ).appendingPathComponent("untitles.json") {          //File Name
            do {
                try jsonData!.write(to: url, options: [])
            } catch let error {
                print("Could not save \(error)")
            }
        }
        
    }
    
    @IBAction func close(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
    }
    
    @IBOutlet var addToCart: UITableView!
    
    var productList = products.Categories(rawValue: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviBar.navigationBar(self)
        
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        
    }
    // MARK: - Table view data source
    @objc func backToCategory(sender: UIButton!) {
        navigationController?.popViewController(animated: true)
    }
    
    //Go to Checkout table
    @objc func goToCheckout(sender: UIButton!) {
        self.performSegue(withIdentifier: "show check out", sender: self)
    }
    
    //Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Row height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
    //Number of rows in section - each row is a prioduct category
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var noOfRows: Int = 0
        
        switch productList {
        case .Fruits:
            noOfRows = products.Fruits.allFruits.count
        case .Vegetables:
            noOfRows = products.Vegetables.allVegetables.count
        case .Bakery:
            noOfRows = products.Bakery.allBakery.count
        case .Dairy:
            noOfRows = products.Dairy.allDairy.count
        case .Snacks:
            noOfRows = products.Snacks.allSnacks.count
        case .Drinks:
            noOfRows = products.Drinks.allDrinks.count
        case .HealthFoods:
            noOfRows = products.HealthFoods.allHealthFoods.count
        case .International:
            noOfRows = products.International.allInternational.count
        case .Home:
            noOfRows = products.Home.allHome.count
        case .Baby:
            noOfRows = products.Baby.allBaby.count
        case .Cleaning:
            noOfRows = products.Cleaning.allCleaning.count
        default:
            noOfRows = products.Cleaning.allCleaning.count
        }
        return noOfRows
    }
    
    //UITable view row reuse
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductList", for: indexPath)
        
        let priceFont = UIFont(name: "Verdana", size: 25) 
        var categoryCell = cell as? ProductListTableViewCell
        
        switch productList {
        case .Fruits:
            categoryCell = fillTheCell(productName: products.Fruits.allFruits[indexPath.row].rawValue, categoryCell: categoryCell!, indexPath: indexPath, priceFont: priceFont!, priceText: products.Fruits.allFruits[indexPath.row].fruitsPrice)
        case .Vegetables:
            categoryCell = fillTheCell(productName: products.Vegetables.allVegetables[indexPath.row].rawValue, categoryCell: categoryCell!, indexPath: indexPath, priceFont: priceFont!, priceText: products.Vegetables.allVegetables[indexPath.row].vegetablesPrice)
        case .Bakery:
            categoryCell = fillTheCell(productName: products.Bakery.allBakery[indexPath.row].rawValue, categoryCell: categoryCell!, indexPath: indexPath, priceFont: priceFont!, priceText: products.Bakery.allBakery[indexPath.row].bakeryPrice)
        case .Dairy:
            categoryCell = fillTheCell(productName: products.Dairy.allDairy[indexPath.row].rawValue, categoryCell: categoryCell!, indexPath: indexPath, priceFont: priceFont!, priceText: products.Dairy.allDairy[indexPath.row].dairyPrice)
        case .Snacks:
            categoryCell = fillTheCell(productName: products.Snacks.allSnacks[indexPath.row].rawValue, categoryCell: categoryCell!, indexPath: indexPath, priceFont: priceFont!,priceText: products.Snacks.allSnacks[indexPath.row].snacksPrice)
        case .Drinks:
            categoryCell = fillTheCell(productName: products.Drinks.allDrinks[indexPath.row].rawValue, categoryCell: categoryCell!, indexPath: indexPath, priceFont: priceFont!, priceText: products.Drinks.allDrinks[indexPath.row].drinksPrice)
        case .HealthFoods:
            categoryCell = fillTheCell(productName: products.HealthFoods.allHealthFoods[indexPath.row].rawValue, categoryCell: categoryCell!, indexPath: indexPath, priceFont: priceFont!, priceText: products.HealthFoods.allHealthFoods[indexPath.row].healthFoodsPrice)
        case .International:
            categoryCell = fillTheCell(productName: products.International.allInternational[indexPath.row].rawValue, categoryCell: categoryCell!, indexPath: indexPath, priceFont: priceFont!, priceText: products.International.allInternational[indexPath.row].internationalPrice)
        case .Home:
            categoryCell = fillTheCell(productName: products.Home.allHome[indexPath.row].rawValue, categoryCell: categoryCell!, indexPath: indexPath, priceFont: priceFont!, priceText: products.Home.allHome[indexPath.row].homePrice)
        case .Baby:
            categoryCell = fillTheCell(productName: products.Baby.allBaby[indexPath.row].rawValue, categoryCell: categoryCell!, indexPath: indexPath, priceFont: priceFont!, priceText: products.Baby.allBaby[indexPath.row].babyPrice)
        case .Cleaning:
            categoryCell = fillTheCell(productName: products.Cleaning.allCleaning[indexPath.row].rawValue, categoryCell: categoryCell!, indexPath: indexPath, priceFont: priceFont!, priceText: products.Cleaning.allCleaning[indexPath.row].cleaningPrice)
        default:
            break
        }
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.layer.shadowOpacity = 0.5
        cell.clipsToBounds = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        print(indexPath)
        
    }
    
    //Product item cell contains - product image, product name and price
    func fillTheCell(productName: String, categoryCell: ProductListTableViewCell, indexPath: IndexPath, priceFont: UIFont, priceText: Double) -> ProductListTableViewCell {
        
        categoryCell.productName.text = productName                                        //Product Name
        categoryCell.cellDelegate = self
        categoryCell.addToCart.tag = indexPath.row
        categoryCell.productImage.image = UIImage(named: productName)                      //Product Image
        categoryCell.priceValue.text = (NSString(format: "%.2f", priceText) as String)     //Formatted Product Price
        
        //Product price formatting
        let priceText = "$" + (NSString(format: "%.2f", priceText) as String)
        print(priceText)
        var count = 0
        for char in priceText {
            count += 1
            if char == "." { break }
        }
        let replaced = priceText.replacingOccurrences(of: ".", with: "")
        count = count - 1
        categoryCell.productPrice.text = replaced
        let attributedString = NSMutableAttributedString(string: categoryCell.productPrice.text!, attributes: [NSAttributedString.Key.font: priceFont.withSize(35) as Any])
        
        
        
        attributedString.setAttributes([NSAttributedString.Key.font: priceFont.withSize(15) as Any, NSAttributedString.Key.baselineOffset: 15], range: NSRange(location: 0, length: 1))
        attributedString.setAttributes([NSAttributedString.Key.font: priceFont.withSize(15) as Any, NSAttributedString.Key.baselineOffset: 15], range: NSRange(location: count, length: 2))
        categoryCell.productPrice.attributedText = attributedString
        
        return categoryCell
    }
    
}

protocol cellSelectDelegate : class{
    func addToCart(_ tag: Int,_ qty: Double,_ product: String,_ productPrice: Float)
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

extension Array where Element: Equatable {
    mutating func removeDuplicates() {
        var result = [Element]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        self = result
    }
}
