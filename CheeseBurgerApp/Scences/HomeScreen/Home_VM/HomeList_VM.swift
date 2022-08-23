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
    
    var upadateshoppingCartMealTuple : Observable<(meals:[Meal],didTapped:(_ meal:Meal) -> ())> = Observable((meals:[],didTapped:{_ in }))
    var upadateSelectedMealTuple : Observable<(selectedMeal:Meal?,didTapped:(_ meal:Meal) -> ())> = Observable((selectedMeal:nil,didTapped:{_ in }))
    var countOfItems: Observable<String> = Observable("")
    var filteredMeals:Observable<[Meal]> = Observable([])
    var wishListMeals:Observable<[Meal]> = Observable([])
    
    
    func getAllMeals() {
        arrayOfMeals.value =
        [[Meal(name: "Cheese Burger", mealDesc: "Burger", price: 10.0,
               currency: "$", imageName: "burger-png-33925 1",
               isLikedYou: false, backgroundImageName: "Rectangle 1", mealSizes: [MealSize(imageName: "burger1", price: 10.0, orderAmount: 0),MealSize(imageName: "burger2", price: 15.0, orderAmount: 0),MealSize(imageName: "burger3", price: 20.0, orderAmount: 0)]),
          Meal(name: "Big Mac", mealDesc: "Burger", price: 20.0, currency: "$", imageName: "burger-png-33925 1", isLikedYou: false, backgroundImageName: "Rectangle 2", mealSizes: [MealSize(imageName: "burger4", price: 10.0, orderAmount: 0),MealSize(imageName: "burger5", price: 15.0, orderAmount: 0),MealSize(imageName: "burger6", price: 20.0, orderAmount: 0)]),
          Meal(name: "Big Tasty", mealDesc: "Burger", price: 30.0, currency: "$", imageName: "burger-png-33925 1", isLikedYou: false, backgroundImageName: "Rectangle 1", mealSizes: [MealSize(imageName: "burger7", price: 10.0, orderAmount:    0),MealSize(imageName: "burger8", price: 15.0, orderAmount: 0),MealSize(imageName: "burger9", price: 20.0, orderAmount: 0)])],
         [Meal(name: "Margarita", mealDesc: "Pizza", price: 10.0,
               currency: "$", imageName: "pizza", isLikedYou: false,
               backgroundImageName: "Rectangle 1",
               mealSizes: [MealSize(imageName: "pizza1",
               price: 10.0, orderAmount: 0),MealSize(imageName: "pizza2", price: 15.0, orderAmount: 0),MealSize(imageName: "pizza3", price: 20.0, orderAmount: 0)]),
          Meal(name: "Vegetables", mealDesc: "Pizza", price: 20.0, currency: "$",
               imageName: "pizza", isLikedYou: false, backgroundImageName: "Rectangle 2", mealSizes: [MealSize(imageName: "pizza4", price: 10.0, orderAmount: 0),MealSize(imageName: "pizza5", price: 15.0, orderAmount: 0),MealSize(imageName: "pizza6", price: 20.0, orderAmount: 0)])]]
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
        
        self.upadateshoppingCartMealTuple.value = (meals: changeCartItems()
                                                   ,
                                                   didTapped: {
            meal in
            
            if let scopeIndex = self.searchBarFilters.value.firstIndex(where: {$0 == meal.mealDesc}),
               let modifiedMealIndex = self.arrayOfMeals.value[scopeIndex]
                .firstIndex(where: {$0.name == meal.name}),
               let mealSizeIndex = self.arrayOfMeals.value[scopeIndex][modifiedMealIndex].mealSizes.firstIndex(where: {$0.imageName == meal.mealSizes[0].imageName && $0.price == meal.mealSizes[0].price})
            {
                
                self.arrayOfMeals.value[scopeIndex][modifiedMealIndex].mealSizes[mealSizeIndex] = meal.mealSizes[0]
            }
            
        })
    }
    
    func changeCartItems() -> [Meal]{
        
        var newArray : [Meal] = []
        let arrayOfCartMealsSize = arrayOfMeals.value.reduce([],+).map{$0.mealSizes}.reduce([],+).filter{$0.orderAmount>0}
        let arr = arrayOfMeals.value.reduce([],+)
        
        var ind = 0
            
        for mealSize in arrayOfCartMealsSize{
            var meal:Meal = arr[ind]
            while !meal.mealSizes.contains(where: {$0 == mealSize}){
                if ind > arr.count - 1{
                    break
                }
                ind += 1
                meal = arr[ind]
            }
            meal.mealSizes = [mealSize]
            
            newArray.append(meal)
        }
        
      return newArray
        
    }
    func countOfCartItems(){
        
        let cartItems = changeCartItems()
        
        
        countOfItems.value = "\(cartItems.map{$0.mealSizes[0].orderAmount}.reduce(0,+))"
        
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
            
            print(searchBarFilters.value[scopeButtonIndex])
            filteredMeals.value = arrayOfMeals.value.reduce([],+)
                .filter{($0.mealDesc.caseInsensitiveCompare(searchBarFilters.value[scopeButtonIndex]) == .orderedSame) && ($0.name.localizedCaseInsensitiveContains(searchBarText))}
        }else{

            filteredMeals.value = arrayOfMeals.value.reduce([],+).filter{($0.mealDesc.caseInsensitiveCompare(searchBarFilters.value[scopeButtonIndex]) == .orderedSame)}
        }
        
    }
}
