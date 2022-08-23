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
            return homeViewModel.searchBarFilters.value.count
        }else{
            return homeViewModel.filteredMeals.value.count}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reuseIdentifier = collectionView.tag == 100 ? "OptionCell" : "BurgerCell"
      
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
            if let cell = cell as? OptionCell{
                cell.segmentedLabel.text = homeViewModel.searchBarFilters.value[indexPath.row]
                return cell
            }
            if let cell = cell as? BurgerCell{
                let meal = homeViewModel.filteredMeals.value[indexPath.row]
                cell.delegate = self
                
                cell.nameLabel.text = meal.name
                cell.backgroundImageView.image = UIImage.init(named: meal.backgroundImageName)
                cell.mealDescLabel.text = meal.mealDesc
                cell.priceLabel.text = "\(meal.price) \(meal.currency)"
                if let image = UIImage.init(named: meal.imageName)
                {
                    cell.mealImageView.image = image
                }
                cell.isLikedYou = meal.isLikedYou
                cell.toggleIsLikedYou = { isLikedYou in
                    if let filterIndex = self.optionsCollection.indexPathsForSelectedItems?.first?.row ,
                       let mealIndex = self.homeViewModel.arrayOfMeals.value[filterIndex].firstIndex(where: {$0.name.localizedCaseInsensitiveContains(meal.name)})
                    {self.homeViewModel.arrayOfMeals.value[filterIndex][mealIndex].isLikedYou = isLikedYou
                    }
                }
                return cell
            }
        return UICollectionViewCell()
    }
    
    
}
