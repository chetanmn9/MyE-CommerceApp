//
//  ProductListTableViewController.swift
//  ArchShopping
//
//  Created by Chetan on 3/3/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import UIKit

class ProductListTableViewController: UITableViewController {

    var naviBar = NavBar()     //call the navigation bar
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviBar.navigationBar(self)
        
        //Set table view attributes
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = .clear
        self.tableView.separatorStyle = .none
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    // MARK: - Table view data source
    //number of sections - each category is sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return products.Categories.all.count
    }
    
    //Table height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    //space between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    //Number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //reuse table rows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCategory", for: indexPath) //as!
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        tableView.separatorStyle = .none

        if let tableSection = products.Categories(rawValue: indexPath.section) {  //row) {
        
        //Assign Category names and description for each
        switch tableSection {
        case .Fruits:
            if let categoryCell = cell as? ProductCategoryCellTableViewCell {
                categoryCell.productCategory = "Fruits"
                for value in products.Fruits.allCases {
                    categoryCell.categoryDescription += value.description + ", "
                }
            }
            break
        case .Vegetables:
            if let categoryCell = cell as? ProductCategoryCellTableViewCell {
                categoryCell.productCategory = "Vegetables"
                for value in products.Vegetables.allCases {
                    categoryCell.categoryDescription += value.description + ", "
                }
            }
        case .Bakery:
            if let categoryCell = cell as? ProductCategoryCellTableViewCell {
                categoryCell.productCategory = "Bakery"
                for value in products.Bakery.allCases {
                    categoryCell.categoryDescription += value.description + ", "
                }
            }
        case .Dairy:
            if let categoryCell = cell as? ProductCategoryCellTableViewCell {
                categoryCell.productCategory = "Dairy"
                for value in products.Dairy.allCases {
                    categoryCell.categoryDescription += value.description + ", "
                }
            }
        case .Snacks:
            if let categoryCell = cell as? ProductCategoryCellTableViewCell {
                categoryCell.productCategory = "Snacks"
                for value in products.Snacks.allCases {
                    categoryCell.categoryDescription += value.description + ", "
                }
            }
        case .International:
            if let categoryCell = cell as? ProductCategoryCellTableViewCell {
                categoryCell.productCategory = "International"
                for value in products.International.allCases {
                    categoryCell.categoryDescription += value.description + ", "
                }
            }
        case .Drinks:
            if let categoryCell = cell as? ProductCategoryCellTableViewCell {
                categoryCell.productCategory = "Drinks"
                for value in products.Drinks.allCases {
                    categoryCell.categoryDescription += value.description + ", "
                }
            }
        case .HealthFoods:
            if let categoryCell = cell as? ProductCategoryCellTableViewCell {
                categoryCell.productCategory = "Health Foods"
                for value in products.HealthFoods.allCases {
                    categoryCell.categoryDescription += value.description + ", "
                }
            }
        case .Home:
            if let categoryCell = cell as? ProductCategoryCellTableViewCell {
                categoryCell.productCategory = "Home"
                for value in products.Home.allCases {
                    categoryCell.categoryDescription += value.description + ", "
                }
            }
        case .Baby:
            if let categoryCell = cell as? ProductCategoryCellTableViewCell {
                categoryCell.productCategory = "Baby"
                for value in products.Baby.allCases {
                    categoryCell.categoryDescription += value.description + ", "
                }
            }
        case .Cleaning:
            if let categoryCell = cell as? ProductCategoryCellTableViewCell {
                categoryCell.productCategory = "Cleaning"
                for value in products.Cleaning.allCases {
                    categoryCell.categoryDescription += value.description + ", "
                }
            }
        }
            
        }
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.layer.shadowOpacity = 0.5
        cell.clipsToBounds = true
        return cell
    }
    
    //When a product category is selected, segue to the next table view to list the category products
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "Show Products", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Products" {
            if let navVC = segue.destination as? ProductDetailsTableViewController {
                    navVC.productList = products.Categories(rawValue: tableView.indexPathForSelectedRow!.section)!
            }
        }
    }
}


