//  SettingsController.swift
//  Giphy
//  Created by Erkan Emir on 22.05.23.

import UIKit
import FirebaseAuth

class SettingsController: UIViewController {
    
    //MARK: - Properties
    var viewModel: SettingsViewModel? {
        didSet {
            configure()
        }
    }
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        
        return iv
    }()
    
    private let titleLabel =  CustomLabel(text: "zzzz", size: 16)
    
    private let editButton: UIButton = {
        let b = UIButton()
        b.setTitle("Edit", for: .normal)
        
        return b
    }()
    
    private lazy var customView: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        v.layer.cornerRadius = 12
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showEditScene)))
        v.isUserInteractionEnabled = true
        return v
    }()
    
    private lazy var logOutButton: UIButton = {
        let b = UIButton()
        b.setTitleColor(UIColor.red, for: .normal)
        b.setTitle("Log Out", for: .normal)
        b.addTarget(self, action: #selector(tappedLogOut), for: .touchUpInside)
        return b
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Actions
    @objc fileprivate func showEditScene() {
        guard let viewModel = viewModel else { return }
        let controller = EditChannelController()
        controller.viewModel = EditsChannelViewModel(items: viewModel.items)
        navigationController?.show(controller, sender: nil)
    }
    
    @objc fileprivate func tappedLogOut() {
        do {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav , animated: false)
            
            try Auth.auth().signOut()
            
        } catch { print("DEBUG: Error") }
    }
    
    func configure() {
        guard let gifURL = viewModel?.gifURL else { return }
        
        if gifURL.pathComponents.contains("media") {
            imageView.setGifFromURL(gifURL,levelOfIntegrity: .highestNoFrameSkipping)
        } else {
            imageView.sd_setImage(with: gifURL)

        }

        titleLabel.text = viewModel?.userName  }
    
    //MARK: - Helpers
    func configureUI() {
        navigationItem.title = "Settings"
        
        view.addSubview(customView)
        customView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 4,paddingLeft: 12,paddingRight: 12)
        customView.setHeight(100)
        
        customView.addSubview(imageView)
        imageView.centerY(inView: customView,leftAnchor: customView.leftAnchor,paddingLeft: 8)
        imageView.setDimensions(height: 60, width: 60)
        
        customView.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.centerY(inView: imageView,leftAnchor: imageView.rightAnchor,paddingLeft: 8)
        
        customView.addSubview(editButton)
        editButton.anchor(top: customView.topAnchor,right: customView.rightAnchor,paddingTop: 34,paddingRight: 8)

        view.addSubview(logOutButton)
        logOutButton.anchor(top: customView.bottomAnchor,left: view.leftAnchor,paddingTop: 12,paddingLeft: 12)
    }
    
    
}
