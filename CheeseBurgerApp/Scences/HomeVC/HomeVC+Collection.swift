//
//  HomeVC+Collection.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 16.08.22.
//

import Foundation
import UIKit

extension HomeVC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 100{
            return 10
        }else{
            return 5}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 100{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionCell", for: indexPath)
            return cell
        }else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BurgerCell", for: indexPath)
            return cell}
    }
    
    
}
