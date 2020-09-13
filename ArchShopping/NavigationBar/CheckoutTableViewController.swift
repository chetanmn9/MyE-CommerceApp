//
//  CheckoutTableViewController.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 11/4/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import UIKit
import MessageUI

class CheckoutTableViewController: UITableViewController {
    
    var readCartItems = Items(itemName: "", itemPrice: 0.0, itemQuantity: 0)
    
    var cartItems: [Items] = [Items(itemName: "", itemPrice: 0.0, itemQuantity: 0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartItems.remove(at: 0)
        let backButton = UIButton()
        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        backButton.addTarget(self, action: #selector(self.close), for: .touchUpInside)
        backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        let listBarButton = UIBarButtonItem(customView: backButton)
        
        self.navigationItem.leftBarButtonItem = listBarButton
        
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ).appendingPathComponent("untitles.json") {
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
                
                for items in cartItems{
                    print(items)
                }
            }
        }
    }
    
    @IBAction func Order(_ sender: Any) {
        
        
        let urlPath = "http://ec2-13-236-95-161.ap-southeast-2.compute.amazonaws.com/order.php"
        
        let url: URL = URL(string: urlPath)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        var itemPrice = 0.0
        
        var orderItemsDictionary = [[ : ]]
        var orderItems = [String:Any]()
        var headerItems = [String : Any]()
        var allOrderItems = [String : Any]()
        
        for items in cartItems {
            
            itemPrice = itemPrice + (Double(items.itemPrice) * Double(items.itemQuantity))
            
            orderItems["zorder_item_name"] = items.itemName
            orderItems["zorder_item_price"] = items.itemPrice
            orderItems["zorder_item_quantity"] = items.itemQuantity
            let orderPrice = (Double(items.itemPrice) * Double(items.itemQuantity))
            orderItems["zorder_price"] = Double(round(100*orderPrice)/100)
            
            
            orderItemsDictionary.append(orderItems)
        }
        itemPrice = Double(round(100*itemPrice)/100)
        
        headerItems["zcustomer_number"] = 333
        headerItems["zcustomer_name"] = "Customer Name"
        headerItems["ztotal_price"] = itemPrice
        
        orderItemsDictionary.remove(at: 0)
        allOrderItems = [ "headerItems" : headerItems, "allItems" : orderItemsDictionary]
        
        var allItems : NSString = ""
        do {
            let arrJson = try JSONSerialization.data(withJSONObject: allOrderItems, options: .prettyPrinted)
            let string = NSString(data: arrJson, encoding: String.Encoding.utf8.rawValue)
            allItems = string! as NSString
        }catch let error as NSError{
            print(error)
        }
        
        let dataD3 = allItems.data(using: String.Encoding.utf8.rawValue)
        
        do
        {
            
            let uploadJob = URLSession.shared.uploadTask(with: request, from: dataD3 )
            {
                data, response, error in
                
                if error != nil {
                    
                    DispatchQueue.main.async
                        {
                            let alert = UIAlertController(title: "Upload Didn't Work?", message: "Looks like the connection to the server didn't work.  Do you have Internet access?", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                    }
                }
                else
                {
                    if let unwrappedData = data {
                        
                        let returnedData = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue) // Response from web server hosting the database
                        
                        if returnedData == "1"
                        {
                            
                            DispatchQueue.main.async
                                {
                                    let alert = UIAlertController(title: "Order Recieved!", message: "Thank you for your order!! please check email for order tracking number.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                                    self.present(alert, animated: true, completion: nil)
                                    
                            }
                        }
                    }
                    else
                    {
                        
                        DispatchQueue.main.async
                            {
                                
                                let alert = UIAlertController(title: "Update Didn't Work", message: "Opps..Looks like something went wrong.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
                
            }
            
            uploadJob.resume()
        }
    }
    
    
    
    @objc func close(sender: UIButton!) {
        print("Button tapped")
        navigationController?.dismiss(animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return cartItems.count
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let label = UILabel()
            label.text = "Total Price"
            label.backgroundColor = UIColor.lightGray
            return label
        } else {
            let label = UILabel()
            label.text = "Items"
            label.backgroundColor = UIColor.lightGray
            return label
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checkout", for: indexPath)
        
        var itemSum: Float = 0.0
        var totalSum: Float = 0.0
        if indexPath.section == 0{
            for items in cartItems {
                itemSum = Float(items.itemQuantity) * items.itemPrice
                totalSum = totalSum + itemSum
            }
            cell.textLabel?.text = "Total: " + (NSString(format: "%.2f", totalSum) as String)    //String(totalSum)
            cell.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        } else {
            cell.textLabel?.text = cartItems[indexPath.row].itemName + " (Qty - " +  String(cartItems[indexPath.row].itemQuantity) + ") ----------------- $" + (NSString(format: "%.2f", cartItems[indexPath.row].itemPrice) as String)   //String(cartItems[indexPath.row].itemPrice)
            cell.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        }
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.cartItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            var allItems: [AnyObject] = []
            for items in cartItems {
                var itemDict: [String : AnyObject] = [:]
                itemDict["itemName"] = items.itemName as AnyObject
                itemDict["itemPrice"] = items.itemPrice as AnyObject
                itemDict["itemQuantity"] = items.itemQuantity as AnyObject
                allItems.append(itemDict as AnyObject)
            }
            
            let jsonData = try? JSONSerialization.data(withJSONObject: allItems, options: .prettyPrinted)
            if let url = try? FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            ).appendingPathComponent("untitles.json") {
                do {
                    try jsonData!.write(to: url, options: [])
                    print("Saved Successfully")
                } catch let error {
                    print("Could not save \(error)")
                }
            }
            
        } else if editingStyle == .insert {
            
        }    
    }
    
    
}
