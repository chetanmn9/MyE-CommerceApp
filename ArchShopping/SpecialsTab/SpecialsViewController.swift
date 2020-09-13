//
//  PromoViewController.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 25/4/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import UIKit

class SpecialsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var naviBar = NavBar()     //setup navigation bar
    
    var flowlayout = UICollectionViewFlowLayout()       //Collection view flowlayout
    
    var collectionView: UICollectionView!
    
    let specials = [ ["Veggies on Special","Snacks on Special","Drinks on Special","Baby Products on Special","Super Foods on Special","Household on Special","Meals on Special","Books on Special","Baking on Special","Ice Cream on Special",],
                     ["Fitness Trackers","Trendy Socks","Furniture Collection","Tech Needs","Bike Collection","Pick your Jeans","T-Shirt Collections","Toys","Fashion Accessories","Fitness Equipments"],
                     ["Mango","Carrot","Milk","Yogurt","Brocolli","Watermelon","IceCream","Bread","Kiwi","Grapes"],
                     ["10% Off First 50 Customers","Its Raining Deals!","Our Geeks can fix it!","Partner with us","Spring Sale!","Tech Bonanza","Hit the like button","Free Delivery!","Join the Club","We are in this together","Customer First.","Join out team","New Clothing Range","Gratude Program, Apply now!"],
                     ["Mango","Carrot","Milk","Yogurt","Brocolli","Watermelon","IceCream","Bread","Kiwi","Grapes"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviBar.navigationBar(self)
        
        flowlayout = ColumnFlowLayout()
        
        //Collection view
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayoutDiffSection())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SpecialsCollectionViewCell.self, forCellWithReuseIdentifier: "SpecialsCell")
        
        configureCollectionView()
    }
    
    //Add collection view to view wit constraints
    func configureCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    
    @objc func backToCategory(sender: UIButton!) {
        navigationController?.popViewController(animated: true)
    }
    
    //segue to check out table
    @objc func goToCheckout(sender: UIButton!) {
        self.performSegue(withIdentifier: "show check out", sender: self)
    }
    
    @objc func goToProducts(sender: UIButton!) {
        self.performSegue(withIdentifier: "Show Specials", sender: self)
    }
    
    //Number of sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return specials.count
        
    }
    
    //No of Items per section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return specials[section].count
        
    }
    
    //Return reusable collection view cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecialsCell", for: indexPath) as? SpecialsCollectionViewCell {
            let image = specials[indexPath.section]
            cell.specialsImage.image = UIImage(named: image[indexPath.row])
            cell.label.text = image[indexPath.row]
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Show Specials", sender: indexPath)
    }
    
    //Segue to specials product list
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Specials" {
            if let navVC = segue.destination as? ProductDetailsTableViewController {
                navVC.productList = products.Categories(rawValue: 1) 
            }
        }
    }

}

//Implemention of Collection view Compositional Layout
func createLayoutDiffSection() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
        layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
        
        var columns = 2

        switch sectionIndex{
        case 0:
            columns = 1
        case 1:
            columns = 2
        case 2:
            columns = 2
        case 3:
            columns = 1
        case 4:
            columns = 3
        default:
            columns = 2
            
        }
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.4), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
        item.contentInsets = columns == 1 ?  NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10) : NSDirectionalEdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5)
        let groupHeight = columns == 1 ?
            NSCollectionLayoutDimension.absolute(350) :
            NSCollectionLayoutDimension.absolute(200)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(365) ,
                                               heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 20, trailing: 5)

        switch sectionIndex{
              case 0:
                  section.orthogonalScrollingBehavior = .continuous
              case 1:
                  section.orthogonalScrollingBehavior = .none
              case 2:
                  section.orthogonalScrollingBehavior = .groupPagingCentered
              case 3:
                  section.orthogonalScrollingBehavior = .groupPaging
              case 4:
                  section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
              default:
                  section.orthogonalScrollingBehavior = .continuous
        }
        return section
    }
    return layout
}

