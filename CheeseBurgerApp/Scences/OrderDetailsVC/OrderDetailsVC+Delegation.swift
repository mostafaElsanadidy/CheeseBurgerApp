//
//  OrderDetailsVC+Delegation.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 17.08.22.
//

import Foundation
import UIKit


extension OrderDetailsVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    // MARK: - Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        
        var numberOfItemsInRow,edgeInset:CGFloat
        var heightPerItem:CGFloat = 0
        
        if collectionView.tag == 100{
          //   height = 100
             edgeInset = 5
             numberOfItemsInRow = 2
            heightPerItem = 47
        }else{
        //    height = 300
            heightPerItem = 250
            edgeInset = 10
            numberOfItemsInRow = 1.3
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
        return 0
    }
    
    
}

