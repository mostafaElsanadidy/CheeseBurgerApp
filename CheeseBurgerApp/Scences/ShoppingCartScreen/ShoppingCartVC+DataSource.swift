//
//  ShoppingCartVC+DataSource.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 22.08.22.
//

import Foundation
import UIKit

extension ShoppingCartVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.shoppingCartViewModel.shoppingCartMeals.value.count)
        return self.shoppingCartViewModel.shoppingCartMeals.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "ShoppingCartCell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? ShoppingCartCell{
            
            let meal = shoppingCartViewModel.shoppingCartMeals.value[indexPath.row]
//                cell.mealImageView.image = UIImage.init(named: meal.imageName)
                cell.delegate = self
//            cell.indexPath = indexPath
                cell.nameLabel.text = meal.name
            cell.mealDescLabel.text = meal.mealDesc.uppercased()
            cell.priceLabel.text = "\(meal.mealSizes[0].price) \(meal.currency)"
            cell.quantityView.isHidden = false
            cell.islikedyouView.isHidden = true
            cell.quantityLabel.text = "\(meal.mealSizes[0].orderAmount)"
//                cell.mealImageView.resized_Image()
                if let image = UIImage.init(named: meal.mealSizes[0].imageName)
                {
//                    cell.mealImageView.image = image.resizeImage(image: cell.mealImageView.image, targetSize: cell.mealImageView.frame.size)
                    cell.burgerImageView.image = image
//                        .resizedImage(withBounds: cell.burgerImageView.bounds.size)
                }
            cell.updateQuantityPrice = {
                print(indexPath)
//                self.shoppingCartViewModel.shoppingCartMeals.value.firstIndex(where: {})
                self.shoppingCartViewModel.quantityPriceDidChange(selectedIndex: indexPath.row, quantityPrice: $0)
                self.shoppingCartViewModel.isPlusBttnClickedflag.value = $1
            }
            
//                cell.islikedyouImageView.image = UIImage.init(named: meal.isLikedYou ? "selected heart" : "heart")
                return cell
            }
        return UITableViewCell()
    }
    
    
    
}
