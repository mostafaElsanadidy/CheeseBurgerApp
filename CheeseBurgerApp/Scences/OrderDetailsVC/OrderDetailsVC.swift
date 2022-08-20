//
//  OrderDetailsVC.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 17.08.22.
//

import UIKit
import UPCarouselFlowLayout

class OrderDetailsVC: UIViewController {

    @IBOutlet weak var optionsCollection: UICollectionView!
    @IBOutlet weak var mealsCollection: UICollectionView!
    @IBOutlet weak var animatedView: UIView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var orderAmountLabel: UILabel!
    @IBOutlet weak var quantityView: UIView!
    
    @IBOutlet weak var countOfCartItemsLabel: UILabel!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealDescLabel: UILabel!
    
    @IBOutlet weak var plusBttn: UIButton!
    @IBOutlet weak var minusBttn: UIButton!
    var selectedMeal:Meal?{
        didSet{
            guard let selectedMeal = selectedMeal else{return}
                selectedMealValueDidChanged?(selectedMeal)
        }
    }
    var selectedMealValueDidChanged : ((_ meal:Meal) -> ())!
    var scopeBttnFilters = ["Active orders","Fast order"]
    
  //  var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        guard let selectedIndex = tabBarController?.tabBar.items?.firstIndex(of: tabBarItem) else{return}
//        tabBarItem.title = ""
//        tabBarItem.image = configureTabBarImage(with: selectedIndex)
//        tabBarItem.selectedImage = configureTabBarImage(with: selectedIndex,isSelectedState: true)
//        tabBarController?.selectedIndex = selectedIndex
        
//        navBarView.popVC = {self.popVCFromNav()}
        setup_Collection()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCountOfCartItemsByNotification), name: Notification.Name(rawValue: "updateCountOfCartItems"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showCountOfCartItems"), object: nil)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if let selectedMeal = selectedMeal{ updateView(with: selectedMeal)}
    }

    @objc func updateCountOfCartItemsByNotification(_ notification:Notification){
        
        countOfCartItemsLabel.text = notification.userInfo!["countOfItems"] as? String
    }

    // MARK: - Setup Collection
    private func setup_Collection() {
        
        optionsCollection.dataSource = self
        optionsCollection.delegate = self
        optionsCollection.register(UINib(nibName: "OptionCell", bundle: nil), forCellWithReuseIdentifier: "OptionCell")
//        mealsCollection.delegate = self
        mealsCollection.dataSource = self
        mealsCollection.register(UINib(nibName: "CarouselBurgerCell", bundle: nil), forCellWithReuseIdentifier: "CarouselBurgerCell")
//        if let layout = mealsCollection.collectionViewLayout as? UPCarouselFlowLayout{
//            layout.spacingMode = .fixed(spacing: 30)
//        }
        
        self.mealsCollection.showsHorizontalScrollIndicator = false
         
         let floawLayout = UPCarouselFlowLayout()
        let itemwidth = UIScreen.main.bounds.size.width - 100
         floawLayout.itemSize = CGSize(width: itemwidth, height: mealsCollection.frame.size.height-30)
         floawLayout.scrollDirection = .horizontal
         floawLayout.sideItemScale = 0.6
         floawLayout.sideItemAlpha = 1.0
         floawLayout.spacingMode = .fixed(spacing: -20)
         mealsCollection.collectionViewLayout = floawLayout
        
//        if let bttn = self.quantityView.viewWithTag(500) as? UIButton {
//            bttn.addTarget(self, action: #selector(didBttnTapped), for: .touchUpInside)
//        }
    }
    
//    @IBAction func didBttnTapped(_ sender: UIButton) {
//        numOfItems += 1
//    }
    @IBAction func didCardBttnTapped(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showCarItems"), object: nil)
    }
    
    @IBAction func didReturnBttnTapped(_ sender: UIButton) {
        self.popVCFromNav()
    }

//    @objc func didBttnTapped(){
//        numOfItems += 1
//        print("mostafa")
//
//    }
    func updateView(with selectedMeal:Meal){
        mealNameLabel.text = selectedMeal.name
        mealDescLabel.text = selectedMeal.mealDesc
        orderAmountLabel.text = "\(selectedMeal.orderAmount ?? 0)"
    }
    
    var numOfItems = 0{
        didSet{
            orderAmountLabel.text = "\(numOfItems)"
            selectedMeal?.orderAmount = numOfItems
       //     updateQuantityPrice(numOfItems)
        }
    }
    
    @IBAction func plusBttnDidTapped(_ sender: UIButton) {
        if let count = Int(orderAmountLabel.text ?? ""),count != 0{
            numOfItems = count }
        numOfItems += 1
        
        minusBttn.isUserInteractionEnabled = numOfItems > 0
        let countOfCartItems = (Int(countOfCartItemsLabel.text ?? "") ?? 0) + 1
        print(countOfCartItems)
        countOfCartItemsLabel.text = "\(countOfCartItems)"
        
    }
    //    @IBAction func plusBttnDidTapped(_ sender: UIButton) {
//        numOfItems += 1
//    }
    @IBAction func minusBttnDidTapped(_ sender: UIButton) {
        if let count = Int(orderAmountLabel.text ?? ""),count != 0{
            numOfItems = count }
//        numOfItems = numOfItems == 0 ? 0 : numOfItems - 1
        numOfItems -= 1
            let countOfCartItems = (Int(countOfCartItemsLabel.text ?? "") ?? 0) - 1
        print(countOfCartItems)
        countOfCartItemsLabel.text = "\(countOfCartItems)"
        if numOfItems == 0{
            sender.isUserInteractionEnabled = false}
        
    }
    
    
    @IBAction func bttnWillAnimated(_ sender: UIButton) {
        
        if self.quantityView.isHidden {
        UIView.transition(with: animatedView, duration: 0.8, options: .transitionFlipFromTop, animations: {
            self.quantityLabel.isHidden.toggle()
            self.quantityView.isHidden.toggle()
            self.orderAmountLabel.text = "\(self.selectedMeal?.orderAmount ?? 0)"

            }, completion: {_ in
        //        self.currentIndex = nextIndex
            })}else{
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "showCarItems"), object: nil)
//                guard let selectedMeal = selectedMeal , selectedMeal.orderAmount > 0 else { return }
//                let cartVC = CartVC()
//
//                if let selectedMealIndex = cartVC.shoppingCartMeals.firstIndex{$0.name == selectedMeal.name && $0.mealDesc == selectedMeal.mealDesc}{
//                    cartVC.shoppingCartMeals[selectedMealIndex] = selectedMeal
//                }else{
//                    cartVC.shoppingCartMeals.append(selectedMeal)
//                }
//
//                cartVC.upadateshoppingCartMeal = {
//                    if $0.name == self.selectedMeal?.name && $0.mealDesc == self.selectedMeal?.mealDesc{
//                        self.selectedMeal?.orderAmount = $0.orderAmount}
//                }
//                self.pushViewController(VC: cartVC)
            }
    }
    @objc func didTimeOut(sender:UIButton) {

//        let isLastIndex = (currentIndex == mainViews.count-1)
//        let nextIndex = isLastIndex ? 0 : currentIndex+1
//        print(currentIndex,nextIndex)
        
        
             
        
                    
//                    self.mainViews[self.currentIndex].isHidden = true
//                    self.mainViews[nextIndex].isHidden = false
                   
        }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.mealsCollection.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    fileprivate var currentPage: Int = 0 {
        didSet {
            print("page at centre = \(currentPage)")
        }
    }
    
    fileprivate var pageSize: CGSize {
        let layout = self.mealsCollection.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
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
