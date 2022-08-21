//
//  HomeVC+Delegation.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 16.08.22.
//

import Foundation
import UIKit
import SwipeCellKit

extension HomeVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SwipeCollectionViewCellDelegate{
    
    // MARK: - Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        
        var numberOfItemsInRow,edgeInset:CGFloat
        var heightPerItem:CGFloat = 0
        
        if collectionView.tag == 100{
          //   height = 100
             edgeInset = 10
             numberOfItemsInRow = 4
            heightPerItem = 50
            
        }else{
        //    height = 300
            heightPerItem = 250
            edgeInset = 0
            numberOfItemsInRow = 1
          //  getFromApiData(recipeHit: arrOfSeparateOrders[indexPath.row])
        }
        let paddingSpace = edgeInset*(numberOfItemsInRow+1)
        let availableWidth = collectionView.frame.size.width-paddingSpace
        let widthPerItem = availableWidth/numberOfItemsInRow
        
        return CGSize(width: widthPerItem,height: heightPerItem)
      }


    // MARK: - Insets
    func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }


    func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
// to know usage of this method change scroll direction of OptionCollection to Vertical instead of Horizental
        return 150
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == optionsCollection{
            let lastIndex = collectionView.numberOfItems(inSection: 0)-1
            
            if (items_willDisplay != [] && indexPath.row == items_willDisplay.max()) || indexPath.row == lastItem_willDisplay{
                
                    let diff = abs(indexPath.row - lastIndex)
                    if diff >= 2{
                        collectionView.scrollToItem(at: IndexPath.init(row:indexPath.row+2, section: 0), at: .right, animated: true)
                    }
                    else{
                        collectionView.scrollToItem(at: IndexPath.init(row:indexPath.row+diff, section: 0), at: .right, animated: true)
                    }
                
                }

            self.homeViewModel.optionCellDidSelected(selectedIndex: indexPath.row, searchBarText: searchBar.text!)
            homeCollection.reloadData()
        }
        else if collectionView == homeCollection{
            if let filterIndex = self.optionsCollection.indexPathsForSelectedItems?.first?.row {
                self.homeViewModel.BurgerCellDidSelected(filteredIndex: filterIndex, selectedRow: indexPath.row)}
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
//            self.filteredMeals.remove(at: indexPath.row)
            
//            self.homeCollection.reloadData()
            action.fulfill(with: .delete)
            guard let scopeButtonIndex = self.optionsCollection.indexPathsForSelectedItems?.first?.row else {return}
            self.homeViewModel.arrayOfMeals.value[scopeButtonIndex].remove(at: indexPath.row)
//            self.filteredMeals.remove(at: indexPath.row)
//            fulfill(with: .delete)
        }
//        deleteAction.transitionDelegate = ScaleTransition.default

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .drag
        return options
    }
}

//extension HomeVC: SwipeActionTransitioning{
//    func didTransition(with context: SwipeActionTransitioningContext) {
//        context.
//    }
//
//}
