//
//  LanguageController.swift
//  Giphy
//
//  Created by Erkan Emir on 16.06.23.
//

import UIKit
import PanModal

class LanguageController: UIViewController {
    
    private lazy var usaImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "usa")
        iv.layer.cornerRadius = 20
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(tappedUSA)))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var arabianImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "saudia")
        iv.layer.cornerRadius = 20
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(tappedSauida)))
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    private lazy var germanyImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "germany")
        iv.layer.cornerRadius = 20
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(tappedGermany)))
        iv.isUserInteractionEnabled = true

        return iv
    }()
    
    override func viewDidLoad() {
        configureUI()
    }
    
    func configureUI() {
        
        let stack = UIStackView(arrangedSubviews: [usaImageView,arabianImageView,germanyImageView])
        view.addSubview(stack)
        stack.axis = .horizontal
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                     left: view.leftAnchor,right: view.rightAnchor,
                     paddingTop: 4,paddingLeft: 4,paddingRight: 4)
        stack.setHeight(60)
        stack.spacing = 20
        stack.distribution = .fillEqually
    }
    
    func configCountry(country: String) {
        UserDefaults.standard.setValue(country, forKey: "appLanguage")
        
        showLoader(true)
        showMessage(withTitle: "restart your app",
                    message: "")
        self.showLoader(false)
    }
    
    @objc func tappedUSA() {
        configCountry(country: "en")
    }
    
    @objc func tappedGermany() {
        configCountry(country: "de")
    }
    
    @objc func tappedSauida() {
        configCountry(country: "ar")
    }
}

extension LanguageController: PanModalPresentable {
        var panScrollable: UIScrollView? { nil }
        var shortFormHeight: PanModalHeight { .contentHeight(60)}
        
        var longFormHeight: PanModalHeight  { .maxHeightWithTopInset(40) }
        
        var cornerRadius: CGFloat { 16 }
}
