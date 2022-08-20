//
//  WishListVC.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 18.08.22.
//

import UIKit

class WishListVC: UIViewController {

    @IBOutlet weak var countOfCartItemsLabel: UILabel!
    @IBOutlet weak var wishListCollection: UICollectionView!
    var wishListMeals:[Meal] = []
    var upadateWishListMeal : ((_ meal:Meal,_ isDeletedState:Bool) -> ())!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let selectedIndex = tabBarController?.tabBar.items?.firstIndex(of: tabBarItem) else{return}
        tabBarItem.title = ""
        tabBarItem.image = configureTabBarImage(with: selectedIndex)
        tabBarItem.selectedImage = configureTabBarImage(with: selectedIndex,isSelectedState: true)
        tabBarController?.selectedIndex = selectedIndex
        setup_Collection()
    }

    // MARK: - Setup Collection
    private func setup_Collection() {
        
        wishListCollection.dataSource = self
        wishListCollection.delegate = self
        wishListCollection.register(UINib(nibName: "WishListCell", bundle: nil), forCellWithReuseIdentifier: "WishListCell")
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCountOfCartItemsByNotification), name: Notification.Name(rawValue: "updateCountOfCartItems"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showCountOfCartItems"), object: nil)
        navigationController?.setNavigationBarHidden(true, animated: animated)
            self.wishListCollection.reloadData()
    }

    @objc func updateCountOfCartItemsByNotification(_ notification:Notification){
        
        countOfCartItemsLabel.text = notification.userInfo!["countOfItems"] as? String
    }
    
    @IBAction func didCardBttnTapped(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showCarItems"), object: nil)
    }
    
    @IBAction func didReturnBttnTapped(_ sender: UIButton) {
        self.popVCFromNav()
    }

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
