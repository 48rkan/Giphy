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
                controller.delegate = self
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
        self.setTabBarAppearance()

        let feed = templateNavigationController(viewController: HomeController(),
                                                selectedImage: UIImage(named: "home_selected")!,
                                                unselectedImage: UIImage(named: "home_unselected")!)
        
        let search = templateNavigationController(viewController: SearchController(),
                                                  selectedImage: UIImage(named: "search_selected")!,
                                                  unselectedImage: UIImage(named: "search_unselected")!)
        
        guard let ownAccount = ownAccount else { return }
        let account = AccountController()
        account.viewModel = AccountViewModel(items: ownAccount, type: .own)
        
        let profile = templateNavigationController(viewController: account,
                                                   selectedImage: UIImage(named: "profile_selected")!,
                                                   unselectedImage: UIImage(named: "profile_unselected")!)
        
        viewControllers = [ feed , search, profile ]
    }
    
    func templateNavigationController(viewController:UIViewController,selectedImage: UIImage ,unselectedImage: UIImage) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.selectedImage = selectedImage
        nav.tabBarItem.image = unselectedImage
        
        return nav
    }
    
    func setTabBarAppearance() {
        let positionOnX: CGFloat = 30
        let positionOnY: CGFloat = 0
        
        let width  = tabBar.bounds.width  - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: positionOnX,
                                y: tabBar.bounds.minY - positionOnY - 20 ,
                                width: width,
                                height: height - 12),
            cornerRadius: height / 20)
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.black.cgColor
        tabBar.tintColor = UIColor.white
        tabBar.unselectedItemTintColor = UIColor.white
    }
}

extension MainTabBarController: LoginControllerDelegate {
    func authenticationDidComplete() {
        fetchOwnAccount()
    }
}
