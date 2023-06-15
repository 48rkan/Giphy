//
//  AccountStatisticsController.swift
//  Giphy
//  Created by Erkan Emir on 15.06.23.

import UIKit
import PanModal

class AccountStatisticsController: UIViewController,PanModalPresentable {
    
    var viewModel: AccountStatisticsViewModel
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        
        return iv
    }()
    
    public let userNameLabel     = CustomLabel(text: "erkan99",
                                               size: 18,
                                               font: Font.pMedium.rawValue)
    
    private let displayNameLabel = CustomLabel(text: "erkan99",
                                               size: 14,
                                               font: Font.pMedium.rawValue)
    
    private let favouritedCountLabel = CustomLabel(text: "0",
                                                   textColor: .lightGray,
                                                   size: 32,
                                                   font: Font.pMedium.rawValue)
    
    private let favouritedLabel = CustomLabel(text: "Favourited",
                                              textColor: .lightGray,
                                              size: 14,
                                              font: Font.pMedium.rawValue)
    
    init(viewModel: AccountStatisticsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congifureUI()
        view.backgroundColor = Color.sealBrown.color()
        configure()

    }
    
    func congifureUI() {
        view.addSubview(profileImageView)
        profileImageView.centerX(inView: view,
                                 topAnchor: view.topAnchor,paddingTop: 16)
        profileImageView.setDimensions(height: 84, width: 84)
        
        view.addSubview(userNameLabel)
        view.addSubview(displayNameLabel)
        userNameLabel.centerX(inView: profileImageView,topAnchor: profileImageView.bottomAnchor,paddingTop: 8)
        displayNameLabel.centerX(inView: profileImageView,topAnchor: userNameLabel.bottomAnchor,paddingTop: 8)
        
        view.addSubview(favouritedCountLabel)
        view.addSubview(favouritedLabel)
        favouritedCountLabel.centerX(inView: displayNameLabel,topAnchor: displayNameLabel.bottomAnchor,paddingTop: 8)
        favouritedLabel.centerX(inView: displayNameLabel,topAnchor: favouritedCountLabel.bottomAnchor,paddingTop: 8)
    }
    
    func configure() {
        userNameLabel.text = viewModel.userName
        displayNameLabel.text = viewModel.displayName
        favouritedCountLabel.text = "\( viewModel.favouritedGifsCount)"
        
        guard let profileUrl = viewModel.profileImageURL else { return }
                
        if profileUrl.pathComponents.contains("giphy") {
            setGifFromURL(imageView: profileImageView, url: profileUrl)
        } else {
            profileImageView.sd_setImage(with: profileUrl)
        }
    }
    

}

extension AccountStatisticsController {
    var panScrollable: UIScrollView? { nil }
    var shortFormHeight: PanModalHeight { .contentHeight(300)}
    
    var longFormHeight: PanModalHeight  { .maxHeightWithTopInset(40) }
    
    var cornerRadius: CGFloat { 16 }
}
