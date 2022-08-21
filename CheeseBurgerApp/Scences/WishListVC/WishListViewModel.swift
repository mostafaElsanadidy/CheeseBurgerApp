//
//  WishListViewModel.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 21.08.22.
//

import Foundation
final class WishListViewModel {
    
    var wishListMeals :Observable<[Meal]> = Observable([])
//    var totalPrice : Observable<Double> = Observable(0)
//    var updateShoppingCartMeal : ((_ meal:Meal) -> ())!
    var upadateWishListMeal : ((_ meal:Meal,_ isDeletedState:Bool) -> ())!
    
}
