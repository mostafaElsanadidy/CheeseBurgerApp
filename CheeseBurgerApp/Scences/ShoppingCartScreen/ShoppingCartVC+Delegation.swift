//
//  ShoppingCartVC+Delegation.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 22.08.22.
//

import Foundation
import UIKit
import SwipeCellKit

extension ShoppingCartVC:UITableViewDelegate,SwipeTableViewCellDelegate{
    
    // MARK: - Cell Size
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//
//        var numberOfItemsInRow,edgeInset:CGFloat
//        var heightPerItem:CGFloat = 0
//
//
//        //    height = 300
//            heightPerItem = 100
//            edgeInset = 0
//            numberOfItemsInRow = 1
//          //  getFromApiData(recipeHit: arrOfSeparateOrders[indexPath.row])
//
//        let paddingSpace = edgeInset*(numberOfItemsInRow+1)
//        let availableWidth = collectionView.frame.size.width-paddingSpace
//        let widthPerItem = availableWidth/numberOfItemsInRow
//
//        return CGSize(width: widthPerItem,height: heightPerItem)
//      }


//    // MARK: - Insets
//    func collectionView(_ collectionView: UICollectionView,
//                      layout collectionViewLayout: UICollectionViewLayout,
//                      insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView,
//                      layout collectionViewLayout: UICollectionViewLayout,
//                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//// to know usage of this method change scroll direction of OptionCollection to Vertical instead of Horizental
//        return 0
//    }
    
    
//    func tableview(_ tableView: UITableView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
//            self.filteredMeals.remove(at: indexPath.row)
            
//            self.homeCollection.reloadData()
            action.fulfill(with: .delete)
            self.shoppingCartViewModel.shoppingCartCellWillDelete(in: indexPath.row)
//            self.filteredMeals.remove(at: indexPath.row)
//            fulfill(with: .delete)
        }
//        deleteAction.transitionDelegate = ScaleTransition.default

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
    }
    
    func tableView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .drag
        return options
    }
    
    
    
    // count of selectedCellsArr/insertedRows
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     //   tableView.deselectRow(at: indexPath, animated: true)
//       // self.selectedCellIndex.append(indexPath.row)
//        if indexPath.section == 0 && indexPath.row == 1{
//        if !isAddressWillChange {
//        showDatePicker()
//        } else{
//        hideDatePicker()
//        }
//        }
    }
    
    func tableView(_tableView: UITableView,indentationLevelForRowAt indexPath: IndexPath)-> Int{
//    var newIndexPath = indexPath
//        let isNotFound = selectedCellsIndex.filter{$0 == indexPath}.isEmpty
//        for ind in 0..<cellsIdentifier[indexPath.section].count{
//            if indexPath.section == 1 && indexPath.row == ind{
//                //        if indexPath.section == 1 && (isAddressWillChange || !isNotFound){
//                newIndexPath = IndexPath(row: 0, section: 0)
//            }
//        }

    var newIndexPath = IndexPath(row: 0, section: 0)
//    }
        return tableView(_tableView: mealsTableView,indentationLevelForRowAt: newIndexPath)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 100
   
    }

     func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
       
            return 100
    }
}

