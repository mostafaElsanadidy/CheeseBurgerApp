//
//  HomeList_VM.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 20.08.22.
//

import Foundation
final class HomeList_VM {
    
    var arrayOfMeals :Observable<[[Meal]]> = Observable([])
    var searchBarFilters : Observable<[String]> = Observable([])
    var upadateWishListMeal : Observable<((_ meal:Meal,_ isDeletedState:Bool) -> ())> = Observable({_,_ in})
//    var shoppingCartMeals:Observable<[Meal]> = Observable([])
    var upadateshoppingCartMealTuple : Observable<(meals:[Meal],didTapped:(_ meal:Meal) -> ())> = Observable((meals:[],didTapped:{_ in }))
    var upadateSelectedMealTuple : Observable<(selectedMeal:Meal?,didTapped:(_ meal:Meal) -> ())> = Observable((selectedMeal:nil,didTapped:{_ in }))
    var countOfItems: Observable<String> = Observable("")
    var filteredMeals:Observable<[Meal]> = Observable([])
    var wishListMeals:Observable<[Meal]> = Observable([])
    
    
    func getAllMeals() {
        arrayOfMeals.value = [[Meal(name: "Cheese Burger", mealDesc: "Burger", price: 10.0,
                                    currency: "$", imageName: "burger-png-33925 1",
           isLikedYou: false, backgroundImageName: "Rectangle 1", subImagesName: ["burger1","burger2","burger3"], orderAmount: 0),
      Meal(name: "Big Mac", mealDesc: "Burger", price: 20.0, currency: "$", imageName: "burger-png-33925 1", isLikedYou: false, backgroundImageName: "Rectangle 2", subImagesName: ["burger4","burger5","burger6"], orderAmount: 0),
      Meal(name: "Big Tasty", mealDesc: "Burger", price: 30.0, currency: "$", imageName: "burger-png-33925 1", isLikedYou: false, backgroundImageName: "Rectangle 1", subImagesName: ["burger7","burger8","burger9"], orderAmount: 0)],[Meal(name: "Margarita", mealDesc: "Pizza", price: 10.0,
                                    currency: "$", imageName: "pizza", isLikedYou: false,
                                                                                                                                                                                                                                                   backgroundImageName: "Rectangle 1", subImagesName: ["pizza1","pizza2","pizza3"], orderAmount: 0),
                                                                                                                                                                                                                                              Meal(name: "Vegetables", mealDesc: "Pizza", price: 20.0, currency: "$", imageName: "pizza", isLikedYou: false, backgroundImageName: "Rectangle 2", subImagesName: ["pizza4","pizza5","pizza6"], orderAmount: 0)]]
        let remainElementsCount = searchBarFilters.value.count - arrayOfMeals.value.count
let remainElements = [[Meal]].init(repeating: [], count: remainElementsCount)
        arrayOfMeals.value.append(contentsOf:remainElements)
    }
    
    func getFilteredMeals(scopeIndex:Int) {
        self.filteredMeals.value = arrayOfMeals.value[scopeIndex]
         
    }
    func getWishListMeals(){
        wishListMeals.value = arrayOfMeals.value.reduce([],+).filter{$0.isLikedYou}
    }
    
    func getSearchBarFilters(){
        self.searchBarFilters.value = ["Burger"
                                       ,"Pizza"
                                       ,"Pasta"
                                       ,"Salad"]
    }
    
    func upadateWishListMealDidChange(){
        self.upadateWishListMeal.value = {
            meal , isDeletedState in
            if let scopeIndex = self.searchBarFilters.value.firstIndex(where: {$0 == meal.mealDesc}),let modifiedMealIndex = self.arrayOfMeals.value[scopeIndex]
                .firstIndex(where: {$0.name == meal.name}){
                if isDeletedState{
                  
                    self.arrayOfMeals.value[scopeIndex][modifiedMealIndex].isLikedYou = false}
            }
            
        }
    }
    
    func showCartItems() {
        
        self.upadateshoppingCartMealTuple.value = (meals: arrayOfMeals.value.reduce([],+).filter{$0.orderAmount>0},
                                                   didTapped: {
            meal in
            
            if let scopeIndex = self.searchBarFilters.value.firstIndex(where: {$0 == meal.mealDesc}),let modifiedMealIndex = self.arrayOfMeals.value[scopeIndex]
                .firstIndex(where: {$0.name == meal.name}){
                self.arrayOfMeals.value[scopeIndex][modifiedMealIndex].orderAmount = meal.orderAmount
            }
            
        })
    }
    
    func countOfCartItems(){
        countOfItems.value = "\(arrayOfMeals.value.reduce([],+).filter{$0.orderAmount>0}.map{$0.orderAmount}.reduce(0,+))"
    }
    
    func optionCellDidSelected(selectedIndex:Int, searchBarText:String){
        self.filteredMeals.value = self.arrayOfMeals.value[selectedIndex]
        if searchBarText != ""{
            self.filteredMeals.value = self.filteredMeals.value.filter{$0.name.localizedCaseInsensitiveContains(searchBarText)}
        }
    }
    
    func BurgerCellDidSelected(filteredIndex:Int,selectedRow:Int) {
        self.upadateSelectedMealTuple.value = (selectedMeal: self.arrayOfMeals.value[filteredIndex][selectedRow],didTapped:{meal in self.arrayOfMeals.value[filteredIndex][selectedRow] = meal})
    }
    
    func searchbttnDidTapped(searchBarText:String, scopeButtonIndex:Int){
        if searchBarText != ""{
//            let scopeButtonIndex = searchBar.selectedScopeButtonIndex
            print(searchBarFilters.value[scopeButtonIndex])
            filteredMeals.value = arrayOfMeals.value.reduce([],+)
                .filter{($0.mealDesc.caseInsensitiveCompare(searchBarFilters.value[scopeButtonIndex]) == .orderedSame) && ($0.name.localizedCaseInsensitiveContains(searchBarText))}
        }else{

            filteredMeals.value = arrayOfMeals.value.reduce([],+).filter{($0.mealDesc.caseInsensitiveCompare(searchBarFilters.value[scopeButtonIndex]) == .orderedSame)}
        }
        
    }
}
