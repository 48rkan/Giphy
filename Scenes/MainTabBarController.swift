//  MainTabBarController.swift
//  Giphy
//  Created by Erkan Emir on 13.05.23.

import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController {
    
    var ownAccount: CommonData? {
        didSet {
            configureViewControllers()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewControllers()
        fetchOwnAccount()
    }
    
    func configureUI() {
        DispatchQueue.main.async {
            if Auth.auth().currentUser == nil {
                let controller = LoginController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false)
            }
        }
    }
    
    func fetchOwnAccount() {
        UserService.fetchUser { account in
            self.ownAccount = account
        }
    }
    
    func configureViewControllers() {
        tabBar.backgroundColor = .white
        
        let feed = templateNavigationController(viewController: HomeController(),
                                                selectedImage: UIImage(named: "home_selected")!,
                                                unselectedImage: UIImage(named: "home_selected")!)
        
        let search = templateNavigationController(viewController: SearchController(),
                                                  selectedImage: UIImage(named: "home_selected")!,
                                                  unselectedImage: UIImage(named: "home_selected")!)
        
        guard let ownAccount = ownAccount else { return }
        let account = AccountController()
        account.viewModel = AccountViewModel(items: ownAccount)
//        account.viewModel = AccountViewModel(items: <#T##CommonData#>)
        let profile = templateNavigationController(viewController: account, selectedImage: UIImage(named: "home_selected")!, unselectedImage: UIImage(named: "home_selected")!)
        
        viewControllers = [ feed , search, profile ]
    }
    
    func templateNavigationController(viewController:UIViewController,selectedImage: UIImage ,unselectedImage: UIImage) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.selectedImage = selectedImage
        nav.tabBarItem.image = unselectedImage
        
        return nav
    }
}
