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
        return self.shoppingCartViewModel.shoppingCartMeals.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "WishListCell"
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? WishListCell{
            
            let meal = shoppingCartViewModel.shoppingCartMeals.value[indexPath.row]
//                cell.mealImageView.image = UIImage.init(named: meal.imageName)
                cell.delegate = self
                
                cell.nameLabel.text = meal.name
            cell.mealDescLabel.text = meal.mealDesc.uppercased()
                cell.priceLabel.text = "\(meal.price) \(meal.currency)"
            cell.quantityView.isHidden = false
            cell.islikedyouView.isHidden = true
            cell.quantityLabel.text = "\(meal.orderAmount)"
//                cell.mealImageView.resized_Image()
                if let image = UIImage.init(named: meal.imageName)
                {
//                    cell.mealImageView.image = image.resizeImage(image: cell.mealImageView.image, targetSize: cell.mealImageView.frame.size)
                    cell.burgerImageView.image = image
//                        .resizedImage(withBounds: cell.burgerImageView.bounds.size)
                }
            cell.updateQuantityPrice = {
                self.shoppingCartViewModel.quantityPriceDidChange(selectedIndex: indexPath.row, quantityPrice: $0)
                self.shoppingCartViewModel.isPlusBttnClickedflag.value = $1
            }
            
//                cell.islikedyouImageView.image = UIImage.init(named: meal.isLikedYou ? "selected heart" : "heart")
                return cell
            }
        return UICollectionViewCell()
    }
    
    
    
}
