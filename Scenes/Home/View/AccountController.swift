//  AccountController.swift
//  Giphy
//  Created by Erkan Emir on 17.05.23.

import UIKit
import SDWebImage

class AccountController: UIViewController {
    
    //MARK: - Properties
    var viewModel: AccountViewModel? {
        didSet {
            configure()
            collection.reloadData()
        }
    }
    
    let bannerImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor(hexString: "#6a18ff")
        return iv
    }()
    
    private var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        return iv
    }()
    
    public let userNameLabel = CustomLabel(text: "MotoGP",
                                            size: 18)
    
    private let displayNameLabel = CustomLabel(text: "@motoGP",
                                               size: 14)
    
    private lazy var settingsButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(systemName: "person.fill"), for: .normal)
        b.tintColor = .black
        b.addTarget(self, action: #selector(tappedSettings), for: .touchUpInside)
        return b
    }()
    
    private lazy var collection: UICollectionView = {
        let l = PinterestLayout()
        l.numberOfColumns = 2
        l.delegate = self
        
        let c = UICollectionView(frame: .zero, collectionViewLayout: l)
        c.register(GiphyCell.self, forCellWithReuseIdentifier: "\(GiphyCell.self)")
        c.delegate   = self
        c.dataSource = self
        c.backgroundColor = .black
        return c
    }()
    
    //MARK: - Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.fetchOwnerGifs()
        viewModel?.fetchFavouritedGifs()
        viewModel?.successCallBack = { self.collection.reloadData() }
        
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.fetchFavouritedGifs()
    }
    
    //MARK: - Actions
    @objc fileprivate func tappedSettings() {
        guard let viewModel = viewModel  else { return }
        
        let controller = SettingsController()
        controller.viewModel = SettingsViewModel(items: viewModel.items)
        navigationController?.show(controller, sender: nil)
    }
    
    //MARK: - Helper
    private func configureUI() {
        view.addSubview(bannerImageView)
        bannerImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 0,paddingLeft: 0,paddingRight: 0)
        bannerImageView.setHeight(100)
        
        view.addSubview(profileImageView)
        profileImageView.centerX(inView: view,topAnchor: bannerImageView.bottomAnchor,paddingTop: -16)
        profileImageView.setDimensions(height: 80, width: 80)
        
        view.addSubview(userNameLabel)
        userNameLabel.centerX(inView: view,topAnchor: profileImageView.bottomAnchor,paddingTop: 4)
        
        view.addSubview(displayNameLabel)
        displayNameLabel.centerX(inView: view,topAnchor: userNameLabel.bottomAnchor,paddingTop: 4)
        
        view.addSubview(collection)
        collection.anchor(top: displayNameLabel.bottomAnchor,
                          left: view.leftAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          right: view.rightAnchor,paddingTop: 12,
                          paddingLeft: 0,paddingBottom: 0,paddingRight: 0)
        
        if viewModel?.type == .own {
            view.addSubview(settingsButton)
            settingsButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,paddingTop: 8,paddingLeft: 8)
            settingsButton.setDimensions(height: 28, width: 28)
        } else { return }
    }
    
    func configure() {
        guard let bannerUrl = viewModel?.bannerURL else { return }
        guard let profileUrl = viewModel?.profileImageURL else { return }
        
        bannerImageView.sd_setImage(with: bannerUrl)
        
        if profileUrl.pathComponents.contains("giphy") {
            profileImageView.setGifFromURL(profileUrl)
        } else {
            profileImageView.sd_setImage(with: profileUrl)
        }
        
        userNameLabel.text    = viewModel?.userName
        displayNameLabel.text = viewModel?.displaName
    }
}

//MARK: - PinterestLayoutDelegate
extension AccountController: PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let random = arc4random_uniform(3) + 1
        return CGFloat(random * 100)
    }
}

extension AccountController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        
        let controller = GiphyDetailController()
        if viewModel.type == .other {
            controller.viewModel = GiphyDetailViewModel(items: viewModel.ownerGifs[indexPath.row])
        } else {
            controller.viewModel = GiphyDetailViewModel(items: viewModel.favouritedGifs[indexPath.row])
        }
        
        navigationController?.show(controller, sender: nil)
    }
}

extension AccountController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        
        return viewModel.type == .other ? viewModel.ownerGifs.count
                                        : viewModel.favouritedGifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell()}
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(GiphyCell.self)", for: indexPath) as! GiphyCell
        
        if viewModel.type == .other {
            cell.viewModel = GiphyCellViewModel(items: viewModel.ownerGifs[indexPath.row])
        } else {
            cell.viewModel = GiphyCellViewModel(items: viewModel.favouritedGifs[indexPath.row])
        }
        return cell
    }
}
