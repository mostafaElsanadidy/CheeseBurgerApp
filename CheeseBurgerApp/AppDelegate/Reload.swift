//
//  Reload.swift
//  MadeInKuwait
//
//  Created by mostafa elsanadidy on 1/29/22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import UIKit
import SideMenuController

protocol ReloadDelegate {
    func goToHomeVC(window:UIWindow)
}

extension ReloadDelegate {
    
    func goToHomeVC(window:UIWindow) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //LOGIN
        let tabBarController = storyboard.instantiateViewController(withIdentifier :"TabbarController") as! TabbarController
        //HOME
    
//        let tabBarController = TabBar_Controller()
        let arrOfVC_ID:[String] = []
        var arrOfVC:[UIViewController] = [HomeVC(),WishListVC(),ThirdTabVC()]
            
            for vcIdentifier in arrOfVC_ID{
                let viewController = storyboard.instantiateViewController(withIdentifier: vcIdentifier)
                arrOfVC.append(viewController)
            }
            tabBarController.viewControllers = arrOfVC
        
            //            // create the side controller
            //        let SideMenuVC = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        for (indx, VC) in tabBarController.viewControllers!.enumerated(){

            VC.tabBarItem = UITabBarItem.init(title: "", image: VC.configureTabBarImage(with: indx), selectedImage: VC.configureTabBarImage(with: indx,isSelectedState: true))
        }
       
//        tabBarController.tabBar.backgroundColor = .red
//        let SideMenuVC = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
//        SideMenuVC.tabBar_Controller = tabBarController
//
//                  let sideMenuViewController = SideMenuController()
//                  // embed the side and center controllers
//                            sideMenuViewController.embed(sideViewController: SideMenuVC)
//                            sideMenuViewController.embed(centerViewController: tabBarController)
        
        let navController = UINavigationController.init(rootViewController: tabBarController)
   
    
    window.rootViewController = navController
        window.makeKeyAndVisible()
    
//    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1, execute: {
//        
//        tabbarController.defaultState()
//        print(tabbarController.selectedIndex)
//        tabbarController.updateVCTabBarDot(vcIndex: 0)
//    })
    
    }
}
