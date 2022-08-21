//
//  OrderDetailsViewModel.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 21.08.22.
//

import Foundation
final class OrderDetailsViewModel {
    
    var selectedMeal : Observable<Meal?> = Observable(nil)
  //  var isPlusBttnClickedflag: Observable<Bool?> = Observable(nil)
//    var scopeBttnFilters : Observable<[String]> = Observable([""])
    
    var selectedMealValueDidChanged : ((_ meal:Meal) -> ())!
    var updateSelectedMeal : Observable<((_ meal:Meal) -> ())?> = Observable(nil)
    
    var scopeBttnFilters = ["Active orders","Fast order"]
    
    var numOfItemsTuple : Observable<(numOfItems:Int,isPlusBttnClickedflag:Bool?)> = Observable((numOfItems:0,isPlusBttnClickedflag:nil))
    
    
    func plusBttnDidTapped(currentCount:Int){
        
        numOfItemsTuple.value = (numOfItems: currentCount + 1 ,
                                 isPlusBttnClickedflag: true)
    }
    
    func minusBttnDidTapped(currentCount: Int) {
         
        numOfItemsTuple.value = (numOfItems: currentCount - 1 ,
                                 isPlusBttnClickedflag: false)
        
            
    }
    func searchSelectedMealAndChange(){
        
        updateSelectedMeal.value = {
            if $0.name == self.selectedMeal.value?.name && $0.mealDesc == self.selectedMeal.value?.mealDesc{
                self.selectedMealWillChange(newOrderAmount: $0.orderAmount)
            }}
    }
    func selectedMealWillChange(newOrderAmount:Int) {
        selectedMeal.value?.orderAmount = newOrderAmount
    }
    
}
