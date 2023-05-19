//  CustomSearchView.swift
//  Giphy
//  Created by Erkan Emir on 18.05.23.

import UIKit

protocol CustomSearchViewDelegate: AnyObject {
    func view(_ searchView: CustomSearchView, editingChangedTextField text: String)
    func searchIconClicked(_ view: CustomSearchView)
}

class CustomSearchView: UIView {
    //MARK: - Properties
    
    weak var delegate: CustomSearchViewDelegate?
    
    public lazy var textField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(
            string: " Search GIPHY",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        tf.font = UIFont(name: "Poppins-ExtraLight", size: 16)
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.backgroundColor = .white
        tf.delegate = self
        tf.addTarget(self, action: #selector(changedTextFieldAction), for: .editingChanged)
                
        return tf
    }()
    
    public lazy var searchIcon: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "searchIcon")
        i.isUserInteractionEnabled = true
        i.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchIconTapped)))
        
        return i
    }()
    
    //MARK:- Actions
    
    @objc private func searchIconTapped() {
        // becomeFirstResponder - kalivaturani acir
        delegate?.searchIconClicked(self)
    }
    
    @objc private func changedTextFieldAction() {
        guard let searchText = textField.text?.lowercased() else { return }
        delegate?.view(self, editingChangedTextField: searchText)
    }
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    func configureUI() {
        addSubview(textField)
        textField.anchor(top: topAnchor,left: leftAnchor,bottom: bottomAnchor,right: rightAnchor,paddingTop: 0,paddingLeft: 0,paddingBottom: 0,paddingRight: 20)
        addSubview(searchIcon)
        searchIcon.anchor(top: topAnchor,right: rightAnchor,paddingTop: 0,paddingRight: 0)
        searchIcon.setDimensions(height: 48, width: 48)
    }
    
}


extension CustomSearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // resign - kalivaturani baglayir
        textField.resignFirstResponder()
        return true
    }
    
    // X duymesine basanda call olunur
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        return true
    }
}
