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
    @IBOutlet weak var countOfCartItemsView: UIViewX!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealDescLabel: UILabel!
    
    
    @IBOutlet weak var plusBttn: UIButton!
    @IBOutlet weak var minusBttn: UIButton!
    
    var orderDetailsViewModel = OrderDetailsViewModel()
    
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
        setupBinder()
        setup_Collection()
    }
    
    func setupBinder(){
        orderDetailsViewModel.selectedMeal.bind{
            [weak self] selectedMeal in
            guard let strongSelf = self else{return}
            DispatchQueue.main.async{
                guard let selectedMeal = selectedMeal else{return}
                strongSelf.orderDetailsViewModel.selectedMealValueDidChanged?(selectedMeal)
                strongSelf.updateView(with: selectedMeal)
//                strongSelf.mealsCollection.reloadData()
            }
        }
        orderDetailsViewModel.numOfItemsTuple.bind{
            [weak self] numOfItemsTuple in
            guard let strongSelf = self else{return}
            DispatchQueue.main.async{
                strongSelf.orderAmountLabel.text = "\(numOfItemsTuple.numOfItems)"
                guard let flag = numOfItemsTuple.isPlusBttnClickedflag else { return }
                strongSelf.minusBttn.isUserInteractionEnabled = flag ? numOfItemsTuple.numOfItems > 0 : numOfItemsTuple.numOfItems != 0
//                strongSelf.minusBttn.isUserInteractionEnabled =
                var countOfCartItems = (Int(strongSelf.countOfCartItemsLabel.text ?? "") ?? 0)
                countOfCartItems =  flag ? countOfCartItems + 1 : countOfCartItems - 1
                print(countOfCartItems)
                strongSelf.countOfCartItemsLabel.text = "\(countOfCartItems)"
                strongSelf.countOfCartItemsView.isHidden = countOfCartItems == 0
                strongSelf.orderDetailsViewModel.selectedMealWillChange(newOrderAmount: Int(numOfItemsTuple.numOfItems))}
            
        }
        orderDetailsViewModel.updateSelectedMeal.bind{
            
            [weak self] updateSelectedMealAction in
            guard let strongSelf = self else{return}
            DispatchQueue.main.async{
                if let cartVC = strongSelf.navigationController?.topViewController as? CartVC{
                cartVC.shoppingCartViewModel.updateSelectedMeal = updateSelectedMealAction
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCountOfCartItemsByNotification), name: Notification.Name(rawValue: "updateCountOfCartItems"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showCountOfCartItems"), object: nil)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        optionsCollection.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .right)
//        if let selectedMeal = selectedMeal{ updateView(with: selectedMeal)}
    }

    @objc func updateCountOfCartItemsByNotification(_ notification:Notification){
        
        let dictionaryValue = notification.userInfo!["countOfItems"] as? String
        countOfCartItemsLabel.text = dictionaryValue ?? ""
        if let value = Int(dictionaryValue ?? "") {
            self.countOfCartItemsView.isHidden = value == 0
        }
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
        orderAmountLabel.text = "\(selectedMeal.orderAmount)"
    }
    
//    var numOfItems = 0{
//        didSet{
//            orderAmountLabel.text = "\(numOfItems)"
//            selectedMeal?.orderAmount = numOfItems
//       //     updateQuantityPrice(numOfItems)
//        }
//    }
    
    @IBAction func plusBttnDidTapped(_ sender: UIButton) {
        
        let count = Int(orderAmountLabel.text ?? "")
        let orderAmount = count != nil ? count : 0
        print(count,orderAmount,orderAmountLabel.text ?? "")
        orderDetailsViewModel.plusBttnDidTapped(currentCount: orderAmount!)
        
        
//        if let count = Int(orderAmountLabel.text ?? ""),count != 0{
//                    numOfItems = count }
//                numOfItems += 1
//
//                minusBttn.isUserInteractionEnabled = numOfItems > 0
//                let countOfCartItems = (Int(countOfCartItemsLabel.text ?? "") ?? 0) + 1
//                print(countOfCartItems)
//                countOfCartItemsLabel.text = "\(countOfCartItems)"
    }
    //    @IBAction func plusBttnDidTapped(_ sender: UIButton) {
//        numOfItems += 1
//    }
    @IBAction func minusBttnDidTapped(_ sender: UIButton) {
        
        let count = Int(orderAmountLabel.text ?? "")
        let orderAmount = count != nil ? count : 0
        orderDetailsViewModel.minusBttnDidTapped(currentCount: orderAmount!)
        
        
        
    }
    
    
    @IBAction func bttnWillAnimated(_ sender: UIButton) {
        
        if self.quantityView.isHidden {
        UIView.transition(with: animatedView, duration: 0.8, options: .transitionFlipFromTop, animations: {
            self.quantityLabel.isHidden.toggle()
            self.quantityView.isHidden.toggle()
            self.orderAmountLabel.text = "\(self.orderDetailsViewModel.selectedMeal.value?.orderAmount ?? 0)"

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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        orderDetailsViewModel.searchSelectedMealAndChange()
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
