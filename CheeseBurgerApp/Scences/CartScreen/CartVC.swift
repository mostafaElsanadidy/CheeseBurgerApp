//
//  CartVC.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 20.08.22.
//

import UIKit

class CartVC: UIViewController {

    @IBOutlet weak var mealsCollection: UICollectionView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var shippingFeedsLabel: UILabel!
    @IBOutlet weak var orderAmountLabel: UILabel!
    @IBOutlet weak var countOfCartItemsLabel: UILabel!
    //    @IBOutlet weak var navBarView: NavBarView!
    var shoppingCartMeals:[Meal] = []{
        didSet{
            self.totalPrice = self.shoppingCartMeals.map{Double($0.orderAmount)*$0.price}.reduce(0, +)
        }
    }
    var upadateshoppingCartMeal : ((_ meal:Meal) -> ())!
    var totalPrice:Double = 0{
        didSet{
            orderAmountLabel?.text = "\(totalPrice) "+shoppingCartMeals[0].currency
            shippingFeedsLabel?.text = "10.0 $"
            totalLabel?.text = "\(totalPrice+10.0)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        navBarView.sideMenuBttn.setImage(UIImage.init(named: "left arrow"), for: .normal)
        
        
        orderAmountLabel.text = "\(totalPrice) $"
        shippingFeedsLabel.text = "10.0 $"
        totalLabel.text = "\(totalPrice+10.0)"
        setup_Collection()
    }

    // MARK: - Setup Collection
    private func setup_Collection() {
        
        mealsCollection.dataSource = self
        mealsCollection.delegate = self
        mealsCollection.register(UINib(nibName: "WishListCell", bundle: nil), forCellWithReuseIdentifier: "WishListCell")
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCountOfCartItemsByNotification), name: Notification.Name(rawValue: "updateCountOfCartItems"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showCountOfCartItems"), object: nil)
        navigationController?.setNavigationBarHidden(true, animated: animated)
            self.mealsCollection.reloadData()
    }

    @objc func updateCountOfCartItemsByNotification(_ notification:Notification){
        
        countOfCartItemsLabel.text = notification.userInfo!["countOfItems"] as? String
    }
    
    @IBAction func didCardBttnTapped(_ sender: UIButton) {
        
//        NotificationCenter.default.post(name: Notification.Name(rawValue: "showCarItems"), object: nil)
        self.mealsCollection.reloadData()
        mealsCollection.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
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
