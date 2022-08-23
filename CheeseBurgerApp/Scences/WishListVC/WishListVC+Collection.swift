//
//  WishListVC+Collection.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 20.08.22.
//

import Foundation
import UIKit

extension WishListVC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishListViewModel.wishListMeals.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "WishListCell"
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? WishListCell{
            
            let meal = wishListViewModel.wishListMeals.value[indexPath.row]
                cell.delegate = self
                
                cell.nameLabel.text = meal.name
            cell.mealDescLabel.text = meal.mealDesc.uppercased()
                cell.priceLabel.text = "\(meal.price) \(meal.currency)"
            cell.quantityView.isHidden = true
            cell.islikedyouView.isHidden = false
                if let image = UIImage.init(named: meal.imageName)
                {   cell.burgerImageView.image = image   }
                return cell
            }
        return UICollectionViewCell()
    }
    
    
    
}
