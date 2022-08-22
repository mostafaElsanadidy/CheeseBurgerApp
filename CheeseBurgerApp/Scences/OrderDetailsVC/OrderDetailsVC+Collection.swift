//
//  OrderDetailsVC+Collection.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 17.08.22.
//

import Foundation
import UIKit

extension OrderDetailsVC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 100{
            return orderDetailsViewModel.scopeBttnFilters.count
        }else{
            return orderDetailsViewModel.selectedMeal.value?.mealSizes.count ?? 0 }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reuseIdentifier = collectionView.tag == 100 ? "OptionCell" : "CarouselBurgerCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        if let cell = cell as? OptionCell{
            cell.segmentedLabel.text = orderDetailsViewModel.scopeBttnFilters[indexPath.row]
            return cell
        }
        if let cell = cell as? CarouselBurgerCell{
            cell.burgerImageView.image = UIImage.init(named: orderDetailsViewModel.selectedMeal.value?.mealSizes[indexPath.row].imageName ?? "")
                return cell
        }
        return UICollectionViewCell()
    }
    
    
}

