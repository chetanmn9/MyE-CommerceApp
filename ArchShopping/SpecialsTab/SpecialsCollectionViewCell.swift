//
//  SpecialsCollectionViewCell.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 25/4/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import UIKit

class SpecialsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "SpecialsCell"
    
    //Colection view container
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)      //.lightGray
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Collection View Image and Label
    let specialsImage = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    // Add Image and label to container view and set constraints
    func configureViews() {
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = .boldSystemFont(ofSize: 16)
        contentView.addSubview(label)
        contentView.addSubview(specialsImage)
        addSubview(containerView)
        containerView.addSubview(specialsImage)
        containerView.addSubview(label)
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        specialsImage.translatesAutoresizingMaskIntoConstraints = false
        specialsImage.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        specialsImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        specialsImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        specialsImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        specialsImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20	).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -5).isActive = true
        label.centerYAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
}
