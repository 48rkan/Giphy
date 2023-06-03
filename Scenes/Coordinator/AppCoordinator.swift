//  HomeCoordinator.swift
//  Giphy
//  Created by Erkan Emir on 28.05.23.

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(window: UIWindow) {
        window.rootViewController = MainTabBarController()
        window.makeKeyAndVisible()
    }
    
    func showGiphyDetail(items: CommonData) {
        let controller = GiphyDetailController()
        controller.viewModel = GiphyDetailViewModel(items: items)
        navigationController.show(controller, sender: nil)
    }
    
    func showAccount(items: CommonData,type: AccountType) {
        let controller = AccountController(viewModel: .init(items: items,
                                                            type: type))
        navigationController.show(controller, sender: nil)
    }
    
    func showLogOut(tabBar: MainTabBarController) {
        let controller = LoginController()
        controller.delegate = tabBar
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        
        navigationController.present(nav , animated: false)
    }
    
    func showSettings(items: CommonData) {
        let controller = SettingsController()
        controller.viewModel = SettingsViewModel(items: items)
        navigationController.show(controller, sender: nil)
    }
    
    func showSearchDetail(items: [Datums],text: String) {
        let controller = SearchDetailController()
        controller.viewModel = SearchDetailViewModel(items: items)
        controller.viewModel?.text = text
        navigationController.show(controller, sender: nil)
    }
    
    func showEditScene(items: CommonData) {
        let controller = EditChannelController()
        controller.viewModel = EditsChannelViewModel(items: items)
        navigationController.show(controller, sender: nil)
    }
}
