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
        iv.backgroundColor = UIColor(hexString: "#353935")

        return iv
    }()
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentPicker)))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let usernameTitle = CustomLabel(text: "Username", size: 16)
    
    private let userNameTextField = CustomTextField(placeholder: "")
    
    //MARK: - Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
    }
    
    //MARK: - Actions
    
    @objc fileprivate func presentPicker() {
        viewModel?.imagePickerConfiguration(completion: { imagePicker in
            
            self.present(imagePicker, animated: true)
            
            imagePicker.didFinishPicking { items, cancelled in
                self.dismiss(animated: false) {
                    // secdiyimiz tek sekile bele catiriq
                    guard let image = items.singlePhoto?.image else { return }
                    self.profileImageView.image = image
                    ImageUploader.changePhoto(image: image)
                }
            }
        })
    }
    func configure() {
        guard let gifURL = viewModel?.gifURL else { return }
        
        if gifURL.pathComponents.contains("media") {
            setGifFromURL(imageView: profileImageView, url: gifURL)
        } else {
            profileImageView.sd_setImage(with: gifURL)
        }
        
        userNameTextField.text = viewModel?.userName
    }
    
    @objc func tappedSave() {
        guard let userNameText = userNameTextField.text else { return }
        UserService.updateUserName(newUsername: userNameText)
        
//        let tabBar = tabBarController as? MainTabBarController
//        tabBar?.fetchOwnAccount()
        navigationController?.popToRootViewController(animated: true)
    }
    
        //MARK: - Helpers
    func configureNavigationBar() {
        let button = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(tappedSave))
        navigationItem.rightBarButtonItem = button
    }
    
    func configureUI() {
        view.addSubview(defaultBannerImageView)
        defaultBannerImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                      left: view.leftAnchor,right: view.rightAnchor,
                                      paddingTop: 0,paddingLeft: 0,paddingRight: 0)
        defaultBannerImageView.setHeight(120)
        
        view.addSubview(profileImageView)
        profileImageView.centerX(inView: view,
                                 topAnchor: defaultBannerImageView.bottomAnchor,paddingTop: -12)
        profileImageView.setDimensions(height: 96, width: 96)
        
        view.addSubview(usernameTitle)
        usernameTitle.anchor(top: profileImageView.bottomAnchor,
                             left: view.leftAnchor,
                             paddingTop: 12,paddingLeft: 8)
        
        view.addSubview(userNameTextField)
        userNameTextField.anchor(top: usernameTitle.bottomAnchor,
                                 left: view.leftAnchor,right: view.rightAnchor,
                                 paddingTop: 4,paddingLeft: 8,paddingRight: 8)
        userNameTextField.setHeight(60)
    }
}
