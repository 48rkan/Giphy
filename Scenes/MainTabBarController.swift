//  MainTabBarController.swift
//  Giphy
//  Created by Erkan Emir on 13.05.23.

import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureViewControllers()
        setTabBarAppearance()
    }
    
    //MARK: - Helper
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
    
    private func configureViewControllers() {
        let feed = templateNavigationController(viewController: HomeController(),
                                                selectedImage: UIImage(named: "home_selected")!,
                                                unselectedImage: UIImage(named: "home_unselected")!)
        
        let search = templateNavigationController(viewController: SearchController(),
                                                  selectedImage: UIImage(named: "search_selected")!,
                                                  unselectedImage: UIImage(named: "search_unselected")!)
        
        let account = AccountController(viewModel: .init(items: nil, type: .own))
        
        let profile = templateNavigationController(viewController: account,
                                                   selectedImage: UIImage(named: "profile_selected")!,
                                                   unselectedImage: UIImage(named: "profile_unselected")!)
        
        viewControllers = [feed, search, profile]
    }
    
    private func templateNavigationController(viewController:UIViewController,
                                              selectedImage: UIImage,
                                              unselectedImage: UIImage) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        return nav
    }
    
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 30
        let positionOnY: CGFloat = 0
        
        let width  = tabBar.bounds.width  - positionOnX * 2
        let height = CGFloat(76)// + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: positionOnX,
                                y: tabBar.bounds.minY - positionOnY - 20 ,
                                width: width,
                                height: height),
            cornerRadius: height / 10 )
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.black.cgColor
        tabBar.tintColor     = UIColor(hexString: "#6a18ff")
        tabBar.unselectedItemTintColor = UIColor.white
    }
}

//MARK: - LoginControllerDelegate
extension MainTabBarController: LoginControllerDelegate {
    func authenticationDidComplete() {
        guard let nav = viewControllers?.first as? UINavigationController else { return }
        guard let account = nav.viewControllers.first as? AccountController else { return }
    
        account.viewModel.getProfile()
    }
}
