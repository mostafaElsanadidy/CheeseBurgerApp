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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                let mealSize = selectedMeal.mealSizes[strongSelf.orderDetailsViewModel.currentPage.value]
                strongSelf.updateView(with: selectedMeal,mealSize: mealSize)
            }
        }
        
        orderDetailsViewModel.currentPage.bind{
            [weak self] currentPage in
            guard let strongSelf = self else{return}
            DispatchQueue.main.async{
                guard let meal = strongSelf.orderDetailsViewModel.selectedMeal.value  else { return }
                let mealSize = meal.mealSizes[currentPage]
                strongSelf.updateView(with: meal,mealSize: mealSize)
            }}
        orderDetailsViewModel.numOfItemsTuple.bind{
            [weak self] numOfItemsTuple in
            guard let strongSelf = self else{return}
            DispatchQueue.main.async{
                strongSelf.orderAmountLabel.text = "\(numOfItemsTuple.numOfItems)"
                strongSelf.orderDetailsViewModel.selectedMealWillChange(newOrderAmount: Int(numOfItemsTuple.numOfItems), mealSizeIndex: strongSelf.orderDetailsViewModel.currentPage.value)
                guard let flag = numOfItemsTuple.isPlusBttnClickedflag else { return }
                strongSelf.minusBttn.isUserInteractionEnabled = flag ? numOfItemsTuple.numOfItems > 0 : numOfItemsTuple.numOfItems != 0
                var countOfCartItems = (Int(strongSelf.countOfCartItemsLabel.text ?? "") ?? 0)
                countOfCartItems =  flag ? countOfCartItems + 1 : countOfCartItems - 1
                print(countOfCartItems)
                strongSelf.countOfCartItemsLabel.text = "\(countOfCartItems)"
                strongSelf.countOfCartItemsView.isHidden = countOfCartItems == 0
       
                
            }
            
        }
        orderDetailsViewModel.updateSelectedMealSize.bind{
            
            [weak self] updateSelectedMealAction in
            guard let strongSelf = self else{return}
            DispatchQueue.main.async{
                if let cartVC = strongSelf.navigationController?.topViewController as? ShoppingCartVC{
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
        orderDetailsViewModel.viewWillAppear()

        print(orderDetailsViewModel.selectedMeal.value)
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
        mealsCollection.delegate = self
        mealsCollection.dataSource = self
        mealsCollection.register(UINib(nibName: "CarouselBurgerCell", bundle: nil), forCellWithReuseIdentifier: "CarouselBurgerCell")
        
        
        self.mealsCollection.showsHorizontalScrollIndicator = false
         
         let floawLayout = UPCarouselFlowLayout()
        let paddingSpace = 10*(1.3+1)
        let availableWidth = mealsCollection.frame.size.width-paddingSpace
        let widthPerItem = availableWidth/1.2
        let itemwidth = CGFloat(widthPerItem)
         floawLayout.itemSize = CGSize(width: itemwidth, height: 250)
         floawLayout.scrollDirection = .horizontal
         floawLayout.sideItemScale = 0.6
         floawLayout.sideItemAlpha = 1.0
//         floawLayout.spacingMode = .fixed(spacing: -40)
         mealsCollection.collectionViewLayout = floawLayout
        
    }
    
    @IBAction func didCardBttnTapped(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showCarItems"), object: nil)
    }
    
    @IBAction func didReturnBttnTapped(_ sender: UIButton) {
        self.popVCFromNav()
    }

    func updateView(with selectedMeal:Meal,mealSize: MealSize? = nil){
        print(mealSize)
        let meal_Size = mealSize == nil ? selectedMeal.mealSizes[0] : mealSize
        
        mealNameLabel.text = selectedMeal.name
        mealDescLabel.text = selectedMeal.mealDesc
        
        orderAmountLabel.text = "\(meal_Size!.orderAmount)"
    }
    
    
    @IBAction func plusBttnDidTapped(_ sender: UIButton) {
        
        let count = Int(orderAmountLabel.text ?? "")
        let orderAmount = count != nil ? count : 0
        print(count,orderAmount,orderAmountLabel.text ?? "")
        orderDetailsViewModel.plusBttnDidTapped(currentCount: orderAmount!)
    }
    
    @IBAction func minusBttnDidTapped(_ sender: UIButton) {
        
        let count = Int(orderAmountLabel.text ?? "")
        let orderAmount = count != nil && count! > 0 ? count : 0
        orderDetailsViewModel.minusBttnDidTapped(currentCount: orderAmount!)

    }
    
    
    @IBAction func bttnWillAnimated(_ sender: UIButton) {
        
        if self.quantityView.isHidden {
        UIView.transition(with: animatedView, duration: 0.8, options: .transitionFlipFromTop, animations: {
            self.quantityLabel.isHidden.toggle()
            self.quantityView.isHidden.toggle()
    
            }, completion: {_ in
             })}else{
                NotificationCenter.default.post(name: Notification.Name(rawValue: "showCarItems"), object: nil)
            }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        orderDetailsViewModel.searchSelectedMealSizeAndChange()
    }
    
    @objc func didTimeOut(sender:UIButton) {                   
        }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.mealsCollection.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        let currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        orderDetailsViewModel.currentPageWillChange(currentPage)
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
