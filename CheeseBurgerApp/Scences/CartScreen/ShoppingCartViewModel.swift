//
//  ShoppingCartViewModel.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 21.08.22.
//

import Foundation

final class ShoppingCartViewModel {
    
    var shoppingCartMeals :Observable<[Meal]> = Observable([])
    var totalPrice : Observable<Double> = Observable(0)
    var isPlusBttnClickedflag : Observable<Bool?> = Observable(nil)
    
    var updateShoppingCartMeal : ((_ meal:Meal) -> ())!
    var updateSelectedMeal : ((_ meal:MealSize) -> ())!
    var collectionWillDeleteCellIndex: Observable<Int?> = Observable(nil)
  
    func quantityPriceDidChange(selectedIndex:Int,quantityPrice:Int){
        
        if quantityPrice == 0{
            
//            shoppingCartCellWillDelete(in: selectedIndex)
            collectionWillDeleteCellIndex.value = selectedIndex
        }else{
            self.shoppingCartMeals.value[selectedIndex].mealSizes[0].orderAmount = quantityPrice
//                collectionView.dele
            MealDidChanged(newValue: self.shoppingCartMeals.value[selectedIndex])}
    }
    

    func totalPriceDidChange(){
        totalPrice.value = shoppingCartMeals.value.map{Double($0.mealSizes[0].orderAmount)*$0.mealSizes[0].price}.reduce(0, +)
    }
    
    func shoppingCartCellWillDelete(in index:Int){
        self.shoppingCartMeals.value[index].mealSizes[0].orderAmount = 0
        let deletedMeal = self.shoppingCartMeals.value.remove(at: index)
        MealDidChanged(newValue: deletedMeal)
    }
    
    func MealDidChanged(newValue newMeal:Meal) {
        totalPriceDidChange()
//        mlkmkl
        self.updateShoppingCartMeal?(newMeal)
        updateSelectedMeal?(newMeal.mealSizes[0])
    }
}

