//  EditChannelController.swift
//  Giphy
//  Created by Erkan Emir on 22.05.23.

import UIKit

class EditChannelController: UIViewController {
    
    //MARK: - Properties
    var viewModel: EditsChannelViewModel? {
        didSet {
            configure()
        }
    }
    
    private let defaultBannerImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        
        return iv
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        
        return iv
    }()
    
    private let usernameTitle = CustomLabel(text: "Username", size: 16)
    
    private let userNameTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "")
        
        return tf
    }()
    
    //MARK: - Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
    }
    
    //MARK: - Actions
    func configure() {
        guard let gifURL = viewModel?.gifURL else { return }
        profileImageView.setGifFromURL(gifURL, showLoader: true)
        userNameTextField.text = viewModel?.userName
    }
    
    @objc func tappedSave() {
        guard let userNameText = userNameTextField.text else { return }
        UserService.updateUserName(newUsername: userNameText)
        
        let tabBar = tabBarController as? MainTabBarController
        tabBar?.fetchOwnAccount()
        navigationController?.popToRootViewController(animated: true)
    }
    
        //MARK: - Helpers
    func configureNavigationBar() {
        let button = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(tappedSave))
        navigationItem.rightBarButtonItem = button
    }
    
    func configureUI() {
        view.addSubview(defaultBannerImageView)
        defaultBannerImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 0,paddingLeft: 0,paddingRight: 0)
        defaultBannerImageView.setHeight(120)
        
        view.addSubview(profileImageView)
        profileImageView.centerX(inView: view,topAnchor: defaultBannerImageView.bottomAnchor,paddingTop: -12)
        profileImageView.setDimensions(height: 96, width: 96)
        
        view.addSubview(usernameTitle)
        usernameTitle.anchor(top: profileImageView.bottomAnchor,left: view.leftAnchor,paddingTop: 12,paddingLeft: 8)
        
        view.addSubview(userNameTextField)
        userNameTextField.anchor(top: usernameTitle.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 4,paddingLeft: 8,paddingRight: 8)
        userNameTextField.setHeight(60)
    }
}
