//
//  OrderDetailsViewModel.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 21.08.22.
//

import Foundation
final class OrderDetailsViewModel {
    
    var selectedMeal : Observable<Meal?> = Observable(nil)
    
    var currentPage: Observable<Int> = Observable(0)

    var selectedMealValueDidChanged : ((_ meal:Meal) -> ())!
    var updateSelectedMealSize : Observable<((_ meal:MealSize) -> ())?> = Observable(nil)
    
    
    var scopeBttnFilters = ["Active orders","Fast order"]
    
    var numOfItemsTuple : Observable<(numOfItems:Int,isPlusBttnClickedflag:Bool?)> = Observable((numOfItems: 0,isPlusBttnClickedflag:nil))
    
    
    func viewWillAppear() {
        self.numOfItemsTuple.value = (numOfItems: selectedMeal.value?.mealSizes[currentPage.value].orderAmount ?? 0, isPlusBttnClickedflag: nil)
    }
    
    func currentPageWillChange(_ value:Int) {
        self.currentPage.value = value
    }
    
    func plusBttnDidTapped(currentCount:Int){
        
        numOfItemsTuple.value = (numOfItems: currentCount + 1 ,
                                 isPlusBttnClickedflag: true)
    }
    
    func minusBttnDidTapped(currentCount: Int) {
        
            numOfItemsTuple.value = (numOfItems: currentCount > 0 ? currentCount - 1 : currentCount ,
                                 isPlusBttnClickedflag: false)
        
            
    }
    func searchSelectedMealSizeAndChange(){
        
        updateSelectedMealSize.value = {
            mealSize in

            if let mealSizeIndex = self.selectedMeal.value?.mealSizes.firstIndex(where: {$0.imageName == mealSize.imageName && $0.price == mealSize.price}){
                self.selectedMealWillChange(newOrderAmount: mealSize.orderAmount, mealSizeIndex: mealSizeIndex)}
            
        }
    }
    func selectedMealWillChange(newOrderAmount:Int?, mealSizeIndex:Int) {
        guard let newOrderAmount = newOrderAmount
//                , let index = selectedMeal.value?.mealSizes.firstIndex(where: {$0.imageName == selectedMealSize?.imageName && $0.price == self.selectedMealSize?.price})
        else {return}
        print(index, "jknjknkj")
        print(newOrderAmount)
        selectedMeal.value?.mealSizes[mealSizeIndex].orderAmount = newOrderAmount
    }
    func addToCart() {
        selectedMealWillChange(newOrderAmount: Int(numOfItemsTuple.value.numOfItems), mealSizeIndex: currentPage.value)
    }
    
}
