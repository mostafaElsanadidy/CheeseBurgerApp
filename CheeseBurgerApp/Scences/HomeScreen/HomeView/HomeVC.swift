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
   // @IBOutlet weak var segmentioView: Segmentio!
//    @IBOutlet weak var countOfCartItemsLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var searchBarFilters = ["Burger"
                            ,"Pizza"
                            ,"Pasta"
                            ,"Salad"]
    var scrollDirection = 0
    var lastContentOffset:CGFloat = 0
   
    var lastItem_willDisplay = 0
    var items_willDisplay:[Int] = []
    
    var arrOfMeals:[[Meal]] = []{
        didSet{
            guard let scopeButtonIndex = self.optionsCollection.indexPathsForSelectedItems?.first?.row else {return}
            filteredMeals = arrOfMeals[scopeButtonIndex]
            let wishListMeals = arrOfMeals.reduce([],+).filter{$0.isLikedYou}
            guard wishListMeals.count > 0 else {return}
            if let wishListVCIndex = tabBarController?.viewControllers?.firstIndex{$0 is WishListVC},let vc = tabBarController?.viewControllers?[wishListVCIndex] as? WishListVC{
                vc.wishListMeals = wishListMeals
                }
        }
    }
    
    var filteredMeals:[Meal] = []{
        didSet{
//            homeCollection.reloadData()
        }
    }
//    var dropDown = DropDown(){
//        didSet{
//            if dropDown.isHidden{
//                searchBar.endEditing(true)
//            }
//        }
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideDropDown))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideDropDown() {
//        if dropDown != nil && dropDown.anchorView?.plainView != nil {
//            dropDown.anchorView?.plainView.removeFromSuperview()
//        }
    }
    
    func initSearchBar() {
    
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
        arrOfMeals = [[Meal(name: "Cheese Burger", mealDesc: "Burger", price: 10.0,
                                                     currency: "$", imageName: "burger-png-33925 1",
                            isLikedYou: false, backgroundImageName: "Rectangle 1", subImagesName: ["burger1","burger2","burger3"], orderAmount: 0),
                       Meal(name: "Big Mac", mealDesc: "Burger", price: 20.0, currency: "$", imageName: "burger-png-33925 1", isLikedYou: false, backgroundImageName: "Rectangle 2", subImagesName: ["burger4","burger5","burger6"], orderAmount: 0),
                       Meal(name: "Big Tasty", mealDesc: "Burger", price: 30.0, currency: "$", imageName: "burger-png-33925 1", isLikedYou: false, backgroundImageName: "Rectangle 1", subImagesName: ["burger7","burger8","burger9"], orderAmount: 0)],[Meal(name: "Margarita", mealDesc: "Pizza", price: 10.0,
                                                     currency: "$", imageName: "pizza", isLikedYou: false,
                                                                                                                                                                                                                                                                    backgroundImageName: "Rectangle 1", subImagesName: ["pizza1","pizza2","pizza3"], orderAmount: 0),
                                                                                                                                                                                                                                                               Meal(name: "Vegetables", mealDesc: "Pizza", price: 20.0, currency: "$", imageName: "pizza", isLikedYou: false, backgroundImageName: "Rectangle 2", subImagesName: ["pizza4","pizza5","pizza6"], orderAmount: 0)]]
        let remainElementsCount = searchBarFilters.count-arrOfMeals.count
        let remainElements = [[Meal]].init(repeating: [], count: remainElementsCount)
        arrOfMeals.append(contentsOf:remainElements)
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
//        let layout = uico
//        homeCollection.layoutc
//        let segmentedView = UIView.init(frame: CGRect.init(x: scrollView.frame.origin.x, y: scrollView.frame.origin.y, width: 80, height: scrollView.frame.height))
//        segmentedView.backgroundColor = .red
//        scrollView.addSubview(segmentedView)
//        scrollView.bringSubviewToFront(segmentedView)
//        updateViews(segmentioView: segmentioView)
        self.view.bringSubviewToFront(scrollView)
        
//        scrollView.isHidden = true
//        homeCollection.contentSize.
//        homeCollection.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        initSearchBar()
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
        if let wishListVCIndex = tabBarController?.viewControllers?.firstIndex(where: {$0 is WishListVC}),let vc = tabBarController?.viewControllers?[wishListVCIndex] as? WishListVC{
            vc.upadateWishListMeal = {
                meal , isDeletedState in
                if let scopeIndex = self.searchBarFilters.firstIndex(where: {$0 == meal.mealDesc}),let modifiedMealIndex = self.arrOfMeals[scopeIndex]
                    .firstIndex(where: {$0.name == meal.name}){
                    if isDeletedState{
                      
                        self.arrOfMeals[scopeIndex][modifiedMealIndex].isLikedYou = false}
                }
                
            }
            }
        homeCollection.reloadData()
    }

//
//    @objc func toggleSideMenu(){
//
//        sideMenuController!.toggle()
//    }
//
    @objc func showCarItems(){
        
        let cartVC = CartVC()
        cartVC.shoppingCartMeals = arrOfMeals.reduce([],+).filter{$0.orderAmount>0}
        cartVC.upadateshoppingCartMeal = {
            meal in
            
            if let scopeIndex = self.searchBarFilters.firstIndex(where: {$0 == meal.mealDesc}),let modifiedMealIndex = self.arrOfMeals[scopeIndex]
                .firstIndex(where: {$0.name == meal.name}){
                self.arrOfMeals[scopeIndex][modifiedMealIndex].orderAmount = meal.orderAmount
            }
            
        }
        self.pushViewController(VC: cartVC)
    }
    
    @objc func countOfCartItems(){
        let dicOfItemsCount = ["countOfItems" : "\(arrOfMeals.reduce([],+).filter{$0.orderAmount>0}.map{$0.orderAmount}.reduce(0,+))"]
        NotificationCenter.default.post(name: Notification.Name(rawValue:"updateCountOfCartItems"), object: nil, userInfo: dicOfItemsCount)
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
        filteredMeals = arrOfMeals[0]
        homeCollection.reloadData()
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
    
    func updateViews(segmentioView: Segmentio) {
        
        segmentioView.semanticContentAttribute = .forceLeftToRight
        var content = [SegmentioItem]()
        
        var tornadoItem = SegmentioItem(
            title: "Communication Info",
            image: UIImage(named: "Wi-Fi"),
            selectedImage: UIImage(named: "inactive2")
        )
        
        content.append(tornadoItem)
        
        tornadoItem = SegmentioItem(
            title: "Project Products",
            image: UIImage(named: "Picture"),
            selectedImage: UIImage(named: "inactive1")
        )
        content.append(tornadoItem)
        
        tornadoItem = SegmentioItem(
            title: "Project Info",
            image: UIImage(named: "Portfolio"),
            selectedImage: UIImage(named: "inactive0")
        )
        
        content.append(tornadoItem)
        
        segmentioView.setup(
            content: content,
            style: .imageOverLabel,
            options: SegmentioOptions(
                backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                segmentPosition: .fixed(maxVisibleItems: 5),
                scrollEnabled: true,
                indicatorOptions: SegmentioIndicatorOptions(
                    type: .bottom,
                    ratio: 1,
                    height: 2,
                    color: #colorLiteral(red: 0.5460985303, green: 0.07448668033, blue: 0.2450374961, alpha: 1)
                ),
                horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions(
                    type: SegmentioHorizontalSeparatorType.top, // Top, Bottom, TopAndBottom
                    height: 0.5,
                    color: .lightGray
                ),
                verticalSeparatorOptions: SegmentioVerticalSeparatorOptions(
                    ratio: 0, // from 0.1 to 1
                    color: .gray
                ),
                imageContentMode: .center,
                labelTextAlignment: .center,
                segmentStates: SegmentioStates(
                    defaultState: SegmentioState(
                        backgroundColor: .clear,
                        titleFont: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),
                        titleTextColor: .gray
                    ),
                    selectedState: SegmentioState(
                        backgroundColor: .red,
                        titleFont: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),
                        titleTextColor: #colorLiteral(red: 0.5755979419, green: 0.0773044005, blue: 0.2239712477, alpha: 0.557416524)
                    ),
                    highlightedState: SegmentioState(
                        backgroundColor: UIColor.lightGray.withAlphaComponent(0.6),
                        titleFont: UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize),
                        titleTextColor: .black
                    )
                )
            )
        )
        
        
//        instantiateViewController()
        segmentioView.selectedSegmentioIndex = 0
       
        segmentioView.valueDidChange = { segmentio, segmentIndex in
            print("Selected item: ", segmentIndex)
            tornadoItem = content[segmentIndex]
            if segmentIndex == 1{
                
            }
            else if segmentIndex == 0{
              
            }
            else if segmentIndex == 2{
              
            }
        }
        
    }

}
