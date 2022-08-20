//
//  File.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 20.08.22.
//

import Foundation
import UIKit

extension CartVC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoppingCartMeals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "WishListCell"
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? WishListCell{
            
                let meal = shoppingCartMeals[indexPath.row]
//                cell.mealImageView.image = UIImage.init(named: meal.imageName)
                cell.delegate = self
                
                cell.nameLabel.text = meal.name
                cell.mealDescLabel.text = meal.mealDesc
                cell.priceLabel.text = "\(meal.price) \(meal.currency)"
            cell.quantityView.isHidden = false
            cell.islikedyouImageView.isHidden = true
            cell.quantityLabel.text = "\(meal.orderAmount)"
//                cell.mealImageView.resized_Image()
                if let image = UIImage.init(named: meal.imageName)
                {
//                    cell.mealImageView.image = image.resizeImage(image: cell.mealImageView.image, targetSize: cell.mealImageView.frame.size)
                    cell.burgerImageView.image = image.resizedImage(withBounds: cell.burgerImageView.bounds.size)
                }
            cell.updateQuantityPrice = {
                self.shoppingCartMeals[indexPath.row].orderAmount = $0
//                collectionView.dele
                self.totalPrice = self.shoppingCartMeals.map{Double($0.orderAmount)*$0.price}.reduce(0, +)
                self.upadateshoppingCartMeal(self.shoppingCartMeals[indexPath.row])
            }
//                cell.islikedyouImageView.image = UIImage.init(named: meal.isLikedYou ? "selected heart" : "heart")
                return cell
            }
        return UICollectionViewCell()
    }
    
    
    
}
