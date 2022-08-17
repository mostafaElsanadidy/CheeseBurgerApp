//
//  HomeVC.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 15.08.22.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var optionsCollection: UICollectionView!
    @IBOutlet weak var homeCollection: UICollectionView!
    var searchBarFilters = ["All"
                            ,"Low Sugar"
                            ,"Keto"
                            ,"Vegan"]
    
    @IBOutlet weak var searchBar: UISearchBar!
    
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
        setup_Collection()
        initSearchBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        let selectedIndex = 0
        
        tabBarItem.title = ""
        tabBarItem.image = configureTabBarImage(with: selectedIndex)
        tabBarItem.selectedImage = configureTabBarImage(with: selectedIndex,isSelectedState: true)
        tabBarController?.selectedIndex = selectedIndex
        
      
    }

    // MARK: - Setup Collection
    private func setup_Collection() {
        
        optionsCollection.dataSource = self
        optionsCollection.delegate = self
        optionsCollection.register(UINib(nibName: "OptionCell", bundle: nil), forCellWithReuseIdentifier: "OptionCell")
        homeCollection.delegate = self
        homeCollection.dataSource = self
        homeCollection.register(UINib(nibName: "BurgerCell", bundle: nil), forCellWithReuseIdentifier: "BurgerCell")
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
