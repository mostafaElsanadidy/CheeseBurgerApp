//
//  WishListViewModel.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 21.08.22.
//

import Foundation
final class WishListViewModel {
    
    var wishListMeals :Observable<[Meal]> = Observable([])
    var upadateWishListMeal : ((_ meal:Meal,_ isDeletedState:Bool) -> ())!
    
}
