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
            return searchBarFilters.count
        }else{
            return filteredMeals.count}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reuseIdentifier = collectionView.tag == 100 ? "OptionCell" : "BurgerCell"
      
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
            if let cell = cell as? OptionCell{
                cell.segmentedLabel.text = searchBarFilters[indexPath.row]
                return cell
            }
            if let cell = cell as? BurgerCell{
                let meal = filteredMeals[indexPath.row]
//                cell.mealImageView.image = UIImage.init(named: meal.imageName)
                cell.delegate = self
                
                cell.nameLabel.text = meal.name
                cell.backgroundImageView.image = UIImage.init(named: meal.backgroundImageName)
                cell.mealDescLabel.text = meal.mealDesc
                cell.priceLabel.text = "\(meal.price) \(meal.currency)"
//                cell.mealImageView.resized_Image()
                if let image = UIImage.init(named: meal.imageName)
                {
//                    cell.mealImageView.image = image.resizeImage(image: cell.mealImageView.image, targetSize: cell.mealImageView.frame.size)
                    cell.mealImageView.image = image.resizedImage(withBounds: cell.mealImageView.bounds.size)
                }
//                cell.islikedyouImageView.image = UIImage.init(named: meal.isLikedYou ? "selected heart" : "heart")
                cell.isLikedYou = meal.isLikedYou
                cell.toggleIsLikedYou = { isLikedYou in
                    if let filterIndex = self.optionsCollection.indexPathsForSelectedItems?.first?.row ,
                       let mealIndex = self.arrOfMeals[filterIndex].firstIndex{$0.name.localizedCaseInsensitiveContains(meal.name)}
                    {self.arrOfMeals[filterIndex][mealIndex].isLikedYou = isLikedYou
//                        self.filteredMeals[mealIndex].isLikedYou = isLikedYou
                    }
                }
                return cell
            }
        return UICollectionViewCell()
    }
    
    
}
