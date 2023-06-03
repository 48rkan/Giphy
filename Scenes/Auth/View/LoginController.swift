//
//  LoginController.swift
//  Giphy
//  Created by Erkan Emir on 13.05.23.

import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

protocol LoginControllerDelegate: AnyObject {
    func authenticationDidComplete()
}

class LoginController: UIViewController {
    
    //MARK: - Properties
    var viewModel = LoginViewModel()
        
    weak var delegate: LoginControllerDelegate?
    
    private lazy var titleLabel = CustomLabel(text: viewModel.titleOne,
                                         textColor: .white,
                                         size: 32,font: "Poppins-Bold")
    
    private lazy var titleLabelOther = CustomLabel(text: viewModel.titleTwo,
                                              textColor: .white,
                                              size: 16,
                                              font: "Poppins-SemiBold")

    private lazy var logInButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = .systemBlue
        b.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 16)
        b.layer.cornerRadius = 12
        b.addTarget(self, action: #selector(tappedLogIn), for: .touchUpInside)
        return b
    }()
    
    private lazy var signUpButton: UIButton = {
        let b = UIButton()
        b.backgroundColor    = .lightGray
        b.titleLabel?.font   = UIFont(name: "Poppins-Medium", size: 16)
        b.layer.cornerRadius = 12
        b.addTarget(self, action: #selector(tappedSignUp), for: .touchUpInside)
        return b
    }()
    
    private let customView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hexString: "8050D7")
        v.layer.cornerRadius = 12
        
        return v
    }()
    
    private let logInLabel = CustomLabel(text: "Log in",
                                         textColor: .white,
                                         size: 16,font: "Poppins-Medium")
    
    private let signUpLabel = CustomLabel(text: "Sign up",
                                         textColor: .white,
                                         size: 16,font: "Poppins-Medium")
        
    private let emailTextField    = CustomTextField(placeholder: "Email")
    
    private let userNameTextField = CustomTextField(placeholder: "Username")
     
    private let passwordTextField = CustomTextField(placeholder: "Password",
                                                    secure: true)

    private lazy var commonButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor(hexString: "8050D7")
        b.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 16)
        b.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return b
    }()
    
    private lazy var googleSignInButton: GIDSignInButton = {
        let b = GIDSignInButton()
        b.addTarget(self, action: #selector(tappedGoggle), for: .touchUpInside)
        
        return b
    }()
    
    private lazy var lastTitleLabel = CustomLabel(text: viewModel.titleThree,
                                                  textColor: .white,
                                                  size: 12,font: "Poppins-Light")
        
    private var usernameHeightConstraint = NSLayoutConstraint()
    
    private var viewLeadingConstraint = NSLayoutConstraint()

    var signUpClicked: Bool = false
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Actions
    private func configureUI() {
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,right: view.rightAnchor,
                          paddingTop: 12,paddingLeft: 12,paddingRight: 12)
        
        view.addSubview(titleLabelOther)
        titleLabelOther.anchor(top: titleLabel.bottomAnchor,
                               left: view.leftAnchor,
                               right: view.rightAnchor,
                               paddingTop: 12,paddingLeft: 24,paddingRight: 12)
        
        view.addSubview(logInButton)
        view.addSubview(signUpButton)
        logInButton.anchor(top: titleLabelOther.bottomAnchor,
                           left: view.leftAnchor,
                           paddingTop: 40,paddingLeft: 12)
        logInButton.setDimensions(height: 44, width: 180)
        
        signUpButton.anchor(top: titleLabelOther.bottomAnchor,
                            right: view.rightAnchor,
                            paddingTop: 40,paddingRight: 12)
        signUpButton.setDimensions(height: 44, width: 180)
                
        view.addSubview(customView)
        customView.anchor(top: titleLabelOther.bottomAnchor, paddingTop: 40)
        customView.setDimensions(height: 44, width: 180)

        viewLeadingConstraint = customView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12)
        viewLeadingConstraint.isActive = true
        
        view.addSubview(logInLabel)
        view.addSubview(signUpLabel)
        logInLabel.centerX(inView: logInButton)
        logInLabel.centerY(inView: logInButton)
        
        signUpLabel.centerX(inView: signUpButton)
        signUpLabel.centerY(inView: signUpButton)
        
        view.addSubview(emailTextField)
        emailTextField.anchor(top: logInButton.bottomAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              paddingTop: 12,
                              paddingLeft: 12,
                              paddingRight: 12)
        emailTextField.setHeight(44)
        
        view.addSubview(userNameTextField)
        userNameTextField.anchor(top: emailTextField.bottomAnchor,
                             left: view.leftAnchor,
                             right: view.rightAnchor,
                             paddingTop: 4,
                             paddingLeft: 12,
                             paddingRight: 12)
        userNameTextField.isHidden = true

        usernameHeightConstraint = userNameTextField.heightAnchor.constraint(equalToConstant: 0)
        usernameHeightConstraint.isActive = true
        
        view.addSubview(passwordTextField)
        passwordTextField.anchor(top: userNameTextField.bottomAnchor,
                                 left: view.leftAnchor,
                                 right: view.rightAnchor,
                                 paddingTop: 4,
                                 paddingLeft: 12,
                                 paddingRight: 12)
        passwordTextField.setHeight(44)
        
        view.addSubview(commonButton)
        commonButton.anchor(top: passwordTextField.bottomAnchor,
                      left: view.leftAnchor,
                      right: view.rightAnchor,
                      paddingTop: 8,
                      paddingLeft: 12,
                      paddingRight: 12)
        commonButton.setHeight(44)
        setButtonTitle()
        
        view.addSubview(googleSignInButton)
        googleSignInButton.anchor(top: commonButton.bottomAnchor, paddingTop: 20)
        googleSignInButton.centerX(inView: view)
        googleSignInButton.setDimensions(height: 100, width: 120)
        
        view.addSubview(lastTitleLabel)
        lastTitleLabel.anchor(left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 24,paddingBottom: 40,paddingRight: 24)
    }
    
    @objc private func tappedLogIn() {
        usernameHeightConstraint.constant = 0
        viewLeadingConstraint.constant = 12

        userNameTextField.isHidden = true
        signUpClicked = false
        setButtonTitle()
        refreshDatas()
        
        UIView.animate(withDuration: 0.3) { self.view.layoutIfNeeded() }
    }
    
    @objc private func tappedSignUp() {
        usernameHeightConstraint.constant = 44
        viewLeadingConstraint.constant = 201
        userNameTextField.isHidden = false
        signUpClicked = true
        setButtonTitle()
        
        UIView.animate(withDuration: 0.3) { self.view.layoutIfNeeded() }
    }
    
    @objc private func buttonClicked() {
        guard let email    = emailTextField.text?.lowercased()    else { return }
        guard let password = passwordTextField.text?.lowercased() else { return }
        guard let username = userNameTextField.text?.lowercased() else { return }
        
        if signUpClicked {
            showLoader(true)
            viewModel.registerUser(credential: AuthCredential(email: email, password: password, username: username)) { error in
                self.showMessage(withTitle: error?.localizedDescription ?? "Ugurlu", message: "")
                self.showLoader(false)
                return
            }
        } else {
            showLoader(true)
            viewModel.logUserIn(email: email, password: password) { data, error in
                if error != nil {
                    self.showMessage(withTitle: error?.localizedDescription ?? "Success", message: "")
                    self.showLoader(false)
                    return
                }
                self.delegate?.authenticationDidComplete()

                self.dismiss(animated: true)
                
            }
        }
    }
    
    @objc private func tappedGoggle() {
        viewModel.tappedGoggle(view: self) {
            self.delegate?.authenticationDidComplete()
            self.dismiss(animated: true)
        }
    }
    
    //MARK:- Helpers
    
    private func setButtonTitle() {
        signUpClicked ? commonButton.setTitle("Sign Up", for: .normal)
                      : commonButton.setTitle("Log In" , for: .normal)
    }

    private func refreshDatas() {
        emailTextField.text    = nil
        userNameTextField.text = nil
        passwordTextField.text = nil
    }
}
