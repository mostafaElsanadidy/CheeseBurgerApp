//
//  HomeVC.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 15.08.22.
//

import UIKit
import Segmentio
import LGSegmentedControl

class HomeVC: UIViewController {

    @IBOutlet weak var optionsCollection: UICollectionView!
    @IBOutlet weak var segmentedView: LGSegmentedControl!
    @IBOutlet weak var homeCollection: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var countOfCartItemsLabel: UILabel!
    @IBOutlet weak var countOfCartItemsView: UIViewX!
    
     var homeViewModel = HomeList_VM()
    
    
    
    
    var scrollDirection = 0
    var lastContentOffset:CGFloat = 0
   
    var lastItem_willDisplay = 0
    var items_willDisplay:[Int] = []
    
    func setupBinder(){
        homeViewModel.arrayOfMeals.bind{
            [weak self] arrayOfMeals in
            guard let strongSelf = self else{return}
            DispatchQueue.main.async{
                guard let scopeButtonIndex = strongSelf.optionsCollection.indexPathsForSelectedItems?.first?.row else {return}
                strongSelf.homeViewModel.getFilteredMeals(scopeIndex: scopeButtonIndex)
                strongSelf.homeViewModel.getWishListMeals()
            }
        }
        homeViewModel.searchBarFilters.bind{[weak self] searchBarFilters in
            guard let strongSelf = self else{return}
            strongSelf.initSearchBar(searchBarFilters: searchBarFilters)
        }
        homeViewModel.upadateWishListMeal.bind{
            [weak self] upadateWishListMeal in
                guard let strongSelf = self else{return}
            if let wishListVCIndex = strongSelf.tabBarController?.viewControllers?.firstIndex(where: {$0 is WishListVC}),let vc = strongSelf.tabBarController?.viewControllers?[wishListVCIndex] as? WishListVC{
                vc.wishListViewModel.upadateWishListMeal = upadateWishListMeal
                }
        }
        homeViewModel.wishListMeals.bind{
            [weak self] wishListMeals in
                guard let strongSelf = self else{return}
            guard wishListMeals.count > 0 else {return}
            if let wishListVCIndex = strongSelf.tabBarController?.viewControllers?.firstIndex(where: {$0 is WishListVC}),let vc = strongSelf.tabBarController?.viewControllers?[wishListVCIndex] as? WishListVC{
                vc.wishListViewModel.wishListMeals.value = wishListMeals
                }
        }
        homeViewModel.upadateshoppingCartMealTuple.bind{
            [weak self] tuple in
                guard let strongSelf = self else{return}
            let cartVC = CartVC()
            cartVC.shoppingCartViewModel.shoppingCartMeals.value = tuple.meals
            cartVC.shoppingCartViewModel.updateShoppingCartMeal = tuple.didTapped
            strongSelf.pushViewController(VC: cartVC)
        }
        homeViewModel.countOfItems.bind{
            [weak self] countOfItems in
            guard let strongSelf = self else{return}
            strongSelf.countOfCartItemsLabel.text = "\(countOfItems)"
           
            if let value = Int(countOfItems) {
                strongSelf.countOfCartItemsView.isHidden = value == 0
            }
            
            let dicOfItemsCount = ["countOfItems" : countOfItems]
            NotificationCenter.default.post(name: Notification.Name(rawValue:"updateCountOfCartItems"), object: nil, userInfo: dicOfItemsCount)
        }
        homeViewModel.upadateSelectedMealTuple.bind{
            
            [weak self] tuple in
                guard let strongSelf = self else{return}
            let orderDetailsVC = OrderDetailsVC()
            orderDetailsVC.orderDetailsViewModel.selectedMeal.value = tuple.selectedMeal
            orderDetailsVC.orderDetailsViewModel.selectedMealValueDidChanged = tuple.didTapped
            strongSelf.tabBarController?.pushViewController(VC:orderDetailsVC)
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideDropDown))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideDropDown() {

        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func initSearchBar(searchBarFilters:[String]) {
    
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.showsCancelButton = false
        searchBar.showsScopeBar = false
        searchBar.scopeButtonTitles = searchBarFilters
        searchBar.delegate = self
        
        //definesPresentationContext = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(showCarItems), name: Notification.Name(rawValue: "showCarItems"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(countOfCartItems), name: Notification.Name(rawValue: "showCountOfCartItems"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: Notification.Name(rawValue: "OpenOrCloseSideMenu"), object: nil)
        
        setupBinder()
        homeViewModel.getSearchBarFilters()
        homeViewModel.getAllMeals()
        setup_Collection()
        scrollView.contentSize = CGSize.init(width: homeCollection.contentSize.width, height: homeCollection.frame.height)
        var config = UICollectionLayoutListConfiguration(appearance: .sidebar)
        config.trailingSwipeActionsConfigurationProvider = { indexPath in
            let del = UIContextualAction(style: .destructive, title: "Delete") {
                [weak self] action, view, completion in
              //  self?.delete(at: indexPath)
                completion(true)
            }
            return UISwipeActionsConfiguration(actions: [del])
        }
        self.view.bringSubviewToFront(scrollView)
    }

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
//        "\(arrOfMeals.reduce([],+).filter{$0.orderAmount>0}.map{$0.orderAmount}.reduce(0,+))"
        guard let selectedIndex = tabBarController?.tabBar.items?.firstIndex(of: tabBarItem) else{return}
        tabBarItem.title = ""
        tabBarItem.image = configureTabBarImage(with: selectedIndex)
        tabBarItem.selectedImage = configureTabBarImage(with: selectedIndex,isSelectedState: true)
        tabBarController?.selectedIndex = selectedIndex
        homeViewModel.upadateWishListMealDidChange()
        homeCollection.reloadData()
        countOfCartItems()
    }

    
    @objc func toggleSideMenu(){
        
//        sideMenuController?.toggle()
    }
    
    @objc func showCarItems(){
        
        homeViewModel.showCartItems()
    }
    
    @objc func countOfCartItems(){
        homeViewModel.countOfCartItems()
    }
    
    // MARK: - Setup Collection
    private func setup_Collection() {
        
        optionsCollection.dataSource = self
        optionsCollection.delegate = self
        optionsCollection.register(UINib(nibName: "OptionCell", bundle: nil), forCellWithReuseIdentifier: "OptionCell")
        homeCollection.delegate = self
        homeCollection.dataSource = self
        homeCollection.register(UINib(nibName: "BurgerCell", bundle: nil), forCellWithReuseIdentifier: "BurgerCell")
        optionsCollection.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .right)
        homeViewModel.getFilteredMeals(scopeIndex: 0)
//        filteredMeals = arrOfMeals[0]
        homeCollection.reloadData()
    }
    
    @IBAction func didCardBttnTapped(_ sender: UIButton) {
        showCarItems()
    }
    
    @IBAction func didSideMenuBttnTapped(_ sender: UIButton) {
     //   self.popVCFromNav()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "OpenOrCloseSideMenu"), object: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == optionsCollection{
                   
            if (self.lastContentOffset > scrollView.contentOffset.x) {
                scrollDirection = 1 //scrolling right
            } else if (self.lastContentOffset < scrollView.contentOffset.x) {
                scrollDirection = -1 //scrolling left
            }

            self.lastContentOffset = scrollView.contentOffset.x;
//            print(scrollDirection)
//                   print("mostafa")
               }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        items_willDisplay = []
      ///  print(items_willDisplay)
        lastItem_willDisplay = indexPath.row
        if scrollDirection == -1{
            for i in 0...3{
                items_willDisplay.append(lastItem_willDisplay-i)
                if lastItem_willDisplay+i <= collectionView.numberOfItems(inSection: 0)-1{
                    }
            }
        }
        else if scrollDirection == 1{
            for i in 0...3{
                 items_willDisplay.append(lastItem_willDisplay+i)
                if lastItem_willDisplay-i >= 0{
                   }
            }
        }}

}
