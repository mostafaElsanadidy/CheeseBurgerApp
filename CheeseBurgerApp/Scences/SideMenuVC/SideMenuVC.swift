//
//  SideMenuVC.swift
//  CheeseBurgerApp
//
//  Created by mostafa elsanadidy on 21.08.22.
//


import UIKit
import SideMenuController

class SideMenuVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
     var sideMenuItems = ["Join to became a chef", "Yumm credit", "Offers", "About us", "Get help", "Invite your friend", "Sign Out"]
    var sideMenuVC = ["OneMealDetailsVC", "", "OffersVC", "AboutUsVC", "GetHelpVC", "ReferralVC", ""]
    
    var tabBar_Controller: TabbarController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SideMenuController.preferences.drawing.menuButtonImage = UIImage(named: "menu")
        SideMenuController.preferences.drawing.sidePanelPosition = .overCenterPanelLeft
     SideMenuController.preferences.drawing.sidePanelWidth = UIScreen.main.bounds.width-70
        SideMenuController.preferences.drawing.centerPanelShadow = true
     SideMenuController.preferences.animating.statusBarBehaviour = .showUnderlay
        setup_Collection()
    }
    
    // MARK: - Setup Collection
    private func setup_Collection() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: "SideMenuCell")
        
    }

    
//    
//    required init?(coder aDecoder: NSCoder) {
//           
//           super.init(coder: aDecoder)
//       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension SideMenuVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath)
        if let label = cell.viewWithTag(100) as? UILabel{
            label.text = sideMenuItems[indexPath.row]
        }
        return cell
    }

}

extension SideMenuVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let indx = tabBar_Controller?.selectedIndex{
            if let viewController = storyboard?.instantiateViewController(withIdentifier: sideMenuVC[indexPath.row]){
           // viewController
              //  viewController.beforeItTabBarVC =
            tabBar_Controller?.viewControllers?[indx] = viewController
                tabBar_Controller?.viewControllers?[indx].tabBarItem.title = ""
                tabBar_Controller?.viewControllers?[indx].tabBarItem.image = configureTabBarImage(with: indx)
                tabBar_Controller?.viewControllers?[indx].tabBarItem.selectedImage = configureTabBarImage(with: indx,isSelectedState: true)
            }}
        tableView.deselectRow(at: indexPath, animated: true)
        sideMenuController!.toggle()
        
    }
}
