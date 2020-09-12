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
    
    var flowlayout = UICollectionViewFlowLayout()       //Colllection view flowlayout
    
    var collectionView: UICollectionView!
    
    let specials = [ ["Promo1","Promo2","Promo3","Promo4","Promo5","Promo6","Promo7","Promo8","Promo9","Promo10",],
                     ["Promo1","Promo2","Promo3","Promo4","Promo5","Promo6","Promo7","Promo8","Promo9","Promo10"],
                     ["Promo1","Promo2","Promo3","Promo4","Promo5","Promo6","Promo7","Promo8","Promo9","Promo10"],
                     ["Promo1","Promo2","Promo3","Promo4","Promo5","Promo6","Promo7","Promo8","Promo9","Promo10"],
                     ["Promo1","Promo2","Promo3","Promo4","Promo5","Promo6","Promo7","Promo8","Promo9","Promo10"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviBar.navigationBar(self)
        
        flowlayout = ColumnFlowLayout()
        
        //Collection view
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayoutDiffSection())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
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

