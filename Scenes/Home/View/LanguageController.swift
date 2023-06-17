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
//        iv.layer.cornerRadius = 20
//        iv.contentMode = .scaleAspectFill
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(tappedUSA)))
        iv.isUserInteractionEnabled = true
        return iv
    }()

    private lazy var arabianImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "saudia")
//        iv.layer.cornerRadius = 20
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(tappedSauida)))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var germanyImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "germany")
//        iv.layer.cornerRadius = 20
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(tappedGermany)))
        iv.isUserInteractionEnabled = true

        return iv
    }()
    
    private let customView1 = UIView()
    private let customView2 = UIView()
    private let customView3 = UIView()
    
    override func viewDidLoad() {
        configureUI()
    }
    
    func configureUI() {
        let stack = UIStackView(arrangedSubviews: [
            customView1,
            customView2,
            customView3
        ])

        view.addSubview(stack)
        stack.axis = .horizontal
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                     left: view.leftAnchor,right: view.rightAnchor,
                     paddingTop: 4,paddingLeft: 4,paddingRight: 4)
        stack.setHeight(60)
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        customView1.addSubview(usaImageView)
        usaImageView.anchor(top: customView1.topAnchor,left: customView1.leftAnchor,bottom: customView1.bottomAnchor,right: customView1.rightAnchor,paddingTop: 4,paddingLeft: 4,paddingBottom: 4,paddingRight: 4)
        usaImageView.layer.cornerRadius = 24
        usaImageView.clipsToBounds = true
        
        customView2.addSubview(arabianImageView)
        arabianImageView.anchor(top: customView2.topAnchor,left: customView2.leftAnchor,bottom: customView2.bottomAnchor,right: customView2.rightAnchor,paddingTop: 4,paddingLeft: 4,paddingBottom: 4,paddingRight: 4)
        arabianImageView.layer.cornerRadius = 24
        arabianImageView.clipsToBounds = true
        
        customView3.addSubview(germanyImageView)
        germanyImageView.anchor(top: customView3.topAnchor,left: customView3.leftAnchor,bottom: customView3.bottomAnchor,right: customView3.rightAnchor,paddingTop: 4,paddingLeft: 4,paddingBottom: 4,paddingRight: 4)
        germanyImageView.layer.cornerRadius = 24
        germanyImageView.clipsToBounds = true
    }
    
    func configCountry(country: String) {
        UserDefaults.standard.setValue(country,
                                       forKey: "appLanguage")
        
        showMessage(withTitle: "Restart your app",
                    message: "") { _ in
            //app'i baglamaq ucun
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                UIApplication.shared
                    .perform(#selector(NSXPCConnection.suspend))
                 DispatchQueue.main.asyncAfter(deadline: .now()) { exit(0) }
            }
        }
    }
    
    @objc func tappedUSA() {
        configCountry(country: "en")
    }
    
    @objc func tappedGermany() {
        configCountry(country: "de")
        
    }
    
    @objc func tappedSauida() {
        configCountry(country: "ar")
        UIView.appearance().semanticContentAttribute = .forceRightToLeft

//        let flipped = originalImage.imageFlippedForRightToLeftLayoutDirection()

    }
}

extension LanguageController: PanModalPresentable {
        var panScrollable: UIScrollView? { nil }
        var shortFormHeight: PanModalHeight { .contentHeight(60)}
        
        var longFormHeight: PanModalHeight  { .maxHeightWithTopInset(40) }
        
        var cornerRadius: CGFloat { 16 }
}
