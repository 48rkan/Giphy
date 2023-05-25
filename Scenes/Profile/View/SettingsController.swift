//  SettingsController.swift
//  Giphy
//  Created by Erkan Emir on 22.05.23.

import UIKit
import FirebaseAuth
import MessageUI
import SafariServices

class SettingsController: UIViewController {
    
    //MARK: - Properties
    var viewModel: SettingsViewModel? {
        didSet {
            configure()
        }
    }
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        
        return iv
    }()
    
    private let titleLabel =  CustomLabel(text: "",hexCode: "#F0EAD6",size: 16,
                                          font: "Poppins-SemiBold")
    
    private let editButton: UIButton = {
        let b = UIButton()
        b.setTitle("Edit", for: .normal)
        b.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
        return b
    }()
    
    private lazy var customView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hexString: "#353935")
        v.layer.cornerRadius = 12
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showEditScene)))
        v.isUserInteractionEnabled = true
        return v
    }()
    
    private lazy var logOutButton: UIButton = {
        let b = UIButton()
        b.setTitleColor(UIColor.red, for: .normal)
        b.setTitle("Log Out", for: .normal)
        b.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 16)
        b.addTarget(self, action: #selector(tappedLogOut), for: .touchUpInside)
        return b
    }()
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.rowHeight  = 64
        t.register(LabelCell.self, forCellReuseIdentifier: "\(LabelCell.self)")
        t.backgroundColor = .black
        t.delegate   = self
        t.dataSource = self
        
        return t
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
            controller.delegate = tabBarController as? MainTabBarController

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
        
        view.addSubview(table)
        table.anchor(top: logOutButton.bottomAnchor,
                     left: view.leftAnchor,
                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                     right: view.rightAnchor,paddingTop: 4,paddingLeft: 4,
                     paddingBottom: 4,paddingRight: 4)
    }
}

extension SettingsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel?.tableTitles[indexPath.row].type {
            
        case .account:
            let sms = "sms:+1234567890&body=Hello Abc How are You I am ios developer."
            let strURL = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            UIApplication.shared.open(URL(string: strURL)!, options: [:], completionHandler: nil)
            
        case .email:
            // Modify following variables with your text / recipient
            let recipientEmail = "test@email.com"
            let subject = "Multi client email support"
            let body = "This code supports sending email via multiple different email apps on iOS! :)"
            
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients([recipientEmail])
                mail.setSubject(subject)
                mail.setMessageBody(body, isHTML: false)
                
                present(mail, animated: true)
            
            } else if let emailUrl = createEmailUrl(to: recipientEmail, subject: subject, body: body) {
                UIApplication.shared.open(emailUrl)
            }
            
        case .privacy:
            guard let url = URL(string: "https://support.giphy.com/hc/en-us/sections/360003012792-Privacy-and-Safety") else { return }

            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
            
        case .rateTheApp:
            guard let url = URL(string: "itms-apps://itunes.apple.com/us/app/apple-store/974748812?mt=8") else { return }
            UIApplication.shared.open(url,completionHandler: nil)
            
        case .acknowLedgements:
            return
            
        case .support:
            // bu appdan linkle sayta getmekdir
            guard let url = URL(string: "https://support.giphy.com/hc/en-us") else { return }

            UIApplication.shared.open(url,completionHandler: nil)
        case _: break
        }
    }
}

extension SettingsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.tableTitles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "\(LabelCell.self)") as! LabelCell
        cell.viewModel = LabelCellViewModel(item: (viewModel?.tableTitles[indexPath.row].title)!)
        return cell
    }
}

extension SettingsController:  MFMailComposeViewControllerDelegate {
    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        
        return defaultUrl
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
