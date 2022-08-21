//
//  SearchVC+SearchBarDelegate.swift
//  RecipesApp
//
//  Created by mostafa elsanadidy on 03.06.22.
//

import Foundation
import UIKit
//import DropDown

extension HomeVC:UISearchBarDelegate{
    
    
    func filterForSearchTextAndScopeButton(searchText:String,scopeButtonIndex:Int = 0) {
        
        
        homeViewModel.searchbttnDidTapped(searchBarText: searchText,scopeButtonIndex: scopeButtonIndex)
        homeCollection.reloadData()
        homeCollection.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let scopeButtonIndex = optionsCollection.indexPathsForSelectedItems?.first?.row
        ,let searchText = searchBar.text else{return}
//        dropDown.hide()
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButtonIndex: scopeButtonIndex)
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
//        searchBar.showsScopeBar = true
//        setupDropDown(with: 0)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
       
//        let scopeButtonIndex = searchBar.selectedScopeButtonIndex
        guard let scopeButtonIndex = optionsCollection.indexPathsForSelectedItems?.first?.row
        ,let searchText = searchBar.text else {return}
//        dropDown.hide()
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButtonIndex: scopeButtonIndex)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if dropDown.isHidden{
//                    dropDown.show()
//                }
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.showsScopeBar = false
        searchBar.endEditing(true)
//        dropDown.hide()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
        //    self.presenter?.loadRecipes()
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
        }else{
//            guard let scopeButtonIndex = optionsCollection.indexPathsForSelectedItems?.first?.row else {return}
//
//            filterForSearchTextAndScopeButton(searchText: searchText, scopeButtonIndex: searchBar.selectedScopeButtonIndex)
        }
        guard let scopeButtonIndex = optionsCollection.indexPathsForSelectedItems?.first?.row else {return}
        print(scopeButtonIndex)
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButtonIndex: scopeButtonIndex)
    }
    
}
