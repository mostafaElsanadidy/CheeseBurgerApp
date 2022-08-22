//
//  Meal.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 18.08.22.
//

import Foundation

struct Meal{
    var name:String
    var mealDesc:String
    var price:Double
    var currency:String
    var imageName:String
    var isLikedYou:Bool
    var backgroundImageName:String
    var mealSizes:[MealSize]
//    var orderAmount:Int
}

struct MealSize:Equatable{
    var imageName:String
    var price:Double
    var orderAmount:Int
}
