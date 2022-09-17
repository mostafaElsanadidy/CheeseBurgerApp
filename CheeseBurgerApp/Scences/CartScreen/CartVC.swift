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
    @IBOutlet weak var countOfCartItemsView: UIViewX!
    
    //    @IBOutlet weak var navBarView: NavBarView!
    var shoppingCartViewModel = ShoppingCartViewModel()
    
//    var shoppingCartMeals:[Meal] = []{
//        didSet{
//            self.totalPrice = self.shoppingCartMeals.map{Double($0.orderAmount)*$0.price}.reduce(0, +)
//        }
//    }
//    var upadateshoppingCartMeal : ((_ meal:Meal) -> ())!
//    var totalPrice:Double = 0{
//        didSet{
//            orderAmountLabel?.text = "\(totalPrice) "+shoppingCartMeals[0].currency
//            shippingFeedsLabel?.text = "10.0 $"
//            totalLabel?.text = "\(totalPrice+10.0)"
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        navBarView.sideMenuBttn.setImage(UIImage.init(named: "left arrow"), for: .normal)
        
        setupBinder()
        shoppingCartViewModel.totalPriceDidChange()
//        orderAmountLabel.text = "\(shoppingCartViewModel.totalPrice.value) $"
//        shippingFeedsLabel.text = "10.0 $"
//        totalLabel.text = "\(shoppingCartViewModel.totalPrice.value+10.0)"
        
        
        setup_Collection()
    }

    func setupBinder(){
        shoppingCartViewModel.shoppingCartMeals.bind{
            [weak self] shoppingCartMeals in
            guard let strongSelf = self else{return}
            DispatchQueue.main.async{
                strongSelf.mealsCollection.reloadData()
            }
        }
        shoppingCartViewModel.totalPrice.bind{
            [weak self] totalPrice in
            guard let strongSelf = self else{return}
            DispatchQueue.main.async{
                strongSelf.orderAmountLabel?.text = "\(totalPrice) "+"$"
                strongSelf.shippingFeedsLabel?.text = "10.0 $"
                strongSelf.totalLabel?.text = "\(totalPrice+10.0)"
                
            }
        }
        shoppingCartViewModel.isPlusBttnClickedflag.bind{
            [weak self] flag in
            guard let strongSelf = self,let flag = flag else{return}
            var countOfCartItems = (Int(strongSelf.countOfCartItemsLabel.text ?? "") ?? 0)
            countOfCartItems =  flag ? countOfCartItems + 1 : countOfCartItems - 1
            
            print(countOfCartItems)
            strongSelf.countOfCartItemsLabel.text = "\(countOfCartItems)"
//            strongSelf.countOfCartItemsView.isHidden = countOfCartItems == 0
//            strongSelf.orderDetailsViewModel.selectedMealWillChange(newOrderAmount: Int(numOfItemsTuple.numOfItems))
        }
        shoppingCartViewModel.collectionWillDeleteCellIndex.bind{
            [weak self] cellIndex in
            guard let strongSelf = self, let cellIndex = cellIndex else{return}
            
//            strongSelf.mealsCollection.beginUpdates()
//            let indexPathDateRow = [IndexPath(row: 0, section: 0),IndexPath(row: 2, section: 0)]
//            print(strongSelf.mealsCollection.indexPathsForVisibleItems)
//            
//            var array = strongSelf.mealsCollection.indexPathsForVisibleItems
//            array = array.filter{$0 != IndexPath(row: cellIndex, section: 0)}
//            print(array)
//            strongSelf.mealsCollection.reloadItems(at: array)
//            strongSelf.mealsCollection.reloadData()
//            strongSelf.mealsCollection.
            
            var visibleRows = strongSelf.mealsCollection.indexPathsForVisibleItems
            let indexPath = IndexPath(row: cellIndex , section: 0)
            for (i,visibleRow) in visibleRows.enumerated(){
                if indexPath == visibleRow{
                    visibleRows.remove(at: i)
                }
            }
            
            var array = strongSelf.shoppingCartViewModel.shoppingCartMeals.value
            guard let index = array.firstIndex(where: {$0.mealDesc == array[cellIndex].mealDesc && $0.mealSizes[0].price == array[cellIndex].mealSizes[0].price})
             else {return}
            array.remove(at: index)
            print(array.map{$0.mealSizes[0]})
            
                strongSelf.mealsCollection.reloadData()
                strongSelf.mealsCollection.deleteItems(at: [IndexPath(row: index, section: 0)])
          
            
//            let count = strongSelf.shoppingCartViewModel.shoppingCartMeals.value.count
//            for i in 0..<count{
//                
//            }
//            strongSelf.mealsCollection.endUpdates()
//            strongSelf.mealsCollection.deleteItems(at: [IndexPath(row: cellIndex, section: 0)])
//            strongSelf.mealsCollection.reloadData()
        }
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
        let dictionaryValue = notification.userInfo!["countOfItems"] as? String
        countOfCartItemsLabel.text = dictionaryValue ?? ""
//        if let value = Int(dictionaryValue ?? "") {
//            self.countOfCartItemsView.isHidden = value == 0
//        }
        
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
