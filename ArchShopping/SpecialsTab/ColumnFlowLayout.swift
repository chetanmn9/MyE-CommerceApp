//
//  ColumnFlowLayout.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 29/4/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import Foundation
import UIKit

class ColumnFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        guard let cv = collectionView else { return }

        let availWidth = cv.bounds.inset(by: cv.layoutMargins).size.width

        let minColumnWidth = CGFloat(300.0)
        let maxNumColumns = Int(availWidth / minColumnWidth)
        let cellWidth = (availWidth / CGFloat(maxNumColumns)).rounded(.down)
        

        self.itemSize = CGSize(width: cellWidth, height: 170.0)

        self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0.0, bottom: 0.0, right: 0.0)

        self.sectionInsetReference = .fromSafeArea
        
    }
}
