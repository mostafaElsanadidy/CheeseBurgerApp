//
//  Tabbar_Controller.swift
//  BudgetPlanning
//
//  Created by mostafa elsanadidy on 11.08.22.
//

import UIKit

class TabbarController: UITabBarController,UITabBarControllerDelegate {
    
    //Outlets
   
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first

        guard let root = keyWindow?.rootViewController else {
            return
        }
        let topSafeArea: CGFloat
        let bottomSafeArea: CGFloat

        if #available(iOS 11.0, *) {
            topSafeArea = root.view.safeAreaInsets.top
            bottomSafeArea = root.view.safeAreaInsets.bottom
        } else {
            topSafeArea = root.topLayoutGuide.length
            bottomSafeArea = root.bottomLayoutGuide.length
        }

        print("topSafeArea : \(topSafeArea)")
        print("bottomSafeArea : \(bottomSafeArea)")

    }
    
    func defaultState(){
        for viewController in viewControllers ?? []{
            viewController.tabBarItem.badgeValue = ""
            viewController.tabBarItem.badgeColor = .clear
            viewController.tabBarItem.setBadgeTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
            let attributes = [NSAttributedString.Key.font:UIFont(name: "HelveticaNeue-UltraLight", size: 20)]
            viewController.tabBarItem.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        }
    }
    //MARK: -
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.defaultState()
        tabBar.semanticContentAttribute = .forceRightToLeft
    }
    
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        
        defaultState()
        guard let vcIndex = viewControllers?.firstIndex(of: viewController) else{return}
        print(vcIndex)
    }
    
    func repositionBadge(tabIndex: Int){

        for badgeView in self.tabBar.subviews[tabIndex].subviews {

            if NSStringFromClass(badgeView.classForCoder) == "_UIBadgeView" {
                badgeView.layer.transform = CATransform3DIdentity
                badgeView.layer.transform = CATransform3DMakeTranslation(25, -5, 1.0)
            }
        }
    }

    
    func updateVCTabBarDot(vcIndex:Int){
    
        guard let viewController = viewControllers?[vcIndex] else {
            return
        }
        viewController.tabBarItem.badgeValue = "●"
        viewController.tabBarItem.badgeColor = .clear
        viewController.tabBarItem.setBadgeTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)], for: .normal)
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            self.repositionBadge(tabIndex: vcIndex)
//        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
 
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        guard let myTabBar = tabBar as? CustomizedTabBar else{return}
//          if (myTabBar.items?[3] == item) {
//              myTabBar.arc = false
//          } else {
//              myTabBar.arc = true
//          }
        
        if let tabBar = self.tabBar as? CustomTabbar{
            
            guard let items = tabBar.items, let vcIndex = items.firstIndex(of: item) else {return}
        //    tabBar.selectedIndex = vcIndex
//            tabBar.setNeedsDisplay()
        }
      }
}
