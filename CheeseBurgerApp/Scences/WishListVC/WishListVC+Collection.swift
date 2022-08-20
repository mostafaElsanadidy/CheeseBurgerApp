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
        return wishListMeals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "WishListCell"
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? WishListCell{
            
                let meal = wishListMeals[indexPath.row]
//                cell.mealImageView.image = UIImage.init(named: meal.imageName)
                cell.delegate = self
                
                cell.nameLabel.text = meal.name
                cell.mealDescLabel.text = meal.mealDesc
                cell.priceLabel.text = "\(meal.price) \(meal.currency)"
            cell.quantityView.isHidden = true
            cell.islikedyouImageView.isHidden = false
//                cell.mealImageView.resized_Image()
                if let image = UIImage.init(named: meal.imageName)
                {
//                    cell.mealImageView.image = image.resizeImage(image: cell.mealImageView.image, targetSize: cell.mealImageView.frame.size)
                    cell.burgerImageView.image = image.resizedImage(withBounds: cell.burgerImageView.bounds.size)
                }
//                cell.islikedyouImageView.image = UIImage.init(named: meal.isLikedYou ? "selected heart" : "heart")
                return cell
            }
        return UICollectionViewCell()
    }
    
    
    
}
