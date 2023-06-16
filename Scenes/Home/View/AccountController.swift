//  AccountController.swift
//  Giphy
//  Created by Erkan Emir on 17.05.23.

import UIKit
import SDWebImage

class AccountController: UIViewController {
    
    //MARK: - Properties
    var coordinator: AppCoordinator?

    var viewModel: AccountViewModel
    
    let bannerImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = Color.midnightBlue.color()
        return iv
    }()
    
    private var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .black
        return iv
    }()
    
    public let userNameLabel     = CustomLabel(text: "",
                                               size: 18,
                                               font: Font.pMedium.rawValue)
    
    private let displayNameLabel = CustomLabel(text: "",
                                               size: 14,
                                               font: Font.pMedium.rawValue)
    
    private lazy var settingsButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(systemName: "person.fill"), for: .normal)
        b.tintColor = .black
        b.addTarget(self, action: #selector(tappedSettings), for: .touchUpInside)
        return b
    }()
    
    private lazy var infoButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(systemName: "info.circle.fill"), for: .normal)
        b.tintColor = .black
        b.addTarget(self, action: #selector(tappedInfo), for: .touchUpInside)
        return b
    }()
    
    private let favouriteLabel = CustomLabel(text: "Favourited Gifs".localize,
                                             textColor: .white,
                                             size: 18)
    
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
    
    init(viewModel: AccountViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:)") }
    
    //MARK: - Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configCoordinator()
        
        showLoader(true)
        viewModel.successCallBack = {
            self.configure()
            self.collection.reloadData()
            self.showLoader(false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getProfile()
    }
        
    //MARK: - Actions
    @objc fileprivate func tappedSettings() {
        guard let items = viewModel.reusableData else { return }
        coordinator?.showSettings(items: items)
    }
    
    @objc fileprivate func tappedInfo() {
        let controller = AccountStatisticsController(viewModel: AccountStatisticsViewModel(accountData: viewModel.reusableData!, favouritedGifsCount: viewModel.ownProfileFavouritedGifs.count))
        navigationController?.presentPanModal(controller)
//        navigationController?.show(controller, sender: nil)
    }
    
    @objc fileprivate func refreshing() {
        viewModel.fetchOwnProfileFavouritedGifs()
        viewModel.fetchOwnAccountData()
        self.collection.refreshControl?.endRefreshing()
    }
        
    //MARK: - Helper
    private func configureUI() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshing), for: .valueChanged)
        self.collection.refreshControl = refresh
        self.collection.refreshControl?.tintColor = .white
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
                          right: view.rightAnchor,paddingTop: 20,
                          paddingLeft: 0,paddingBottom: 0,paddingRight: 0)
        
        if viewModel.type == .own {
            view.addSubview(settingsButton)
            settingsButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,paddingTop: 8,paddingLeft: 8)
            settingsButton.setDimensions(height: 32, width: 32)
            
            view.addSubview(infoButton)
            infoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,right: view.rightAnchor,paddingTop: 8,paddingRight: 8)
            infoButton.setDimensions(height: 32, width: 32)
            
            view.addSubview(favouriteLabel)
            favouriteLabel.anchor(top: displayNameLabel.bottomAnchor,left: view.leftAnchor,paddingTop: 0,paddingLeft: 4)
        } else { return }
    }
    
    func configure() {
        userNameLabel.text    = viewModel.userName
        displayNameLabel.text = viewModel.displaName
        
//        guard let bannerUrl = viewModel.bannerURL else { return }
        guard let profileUrl = viewModel.profileImageURL else { return }
        
        bannerImageView.sd_setImage(with: viewModel.bannerURL ?? URL(string: ""))
        
        if profileUrl.pathComponents.contains("giphy") {
            setGifFromURL(imageView: profileImageView, url: (viewModel.bannerURL ?? URL(string: ""))!)
        } else {
            profileImageView.sd_setImage(with: profileUrl)
        }
    }
    
    func configCoordinator() {
        guard let nav = navigationController else { return }
        coordinator = AppCoordinator(navigationController: nav)
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
//        guard let viewModel = viewModel else { return }
        
        let controller = GiphyDetailController()
        if viewModel.type == .other {
            controller.viewModel = GiphyDetailViewModel(items: viewModel.otherProfileOwnerGifs[indexPath.row])
        } else {
            return
        }
        
        navigationController?.show(controller, sender: nil)
    }
}

extension AccountController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        guard let viewModel = viewModel else { return 0 }
        
        return viewModel.type == .other ? viewModel.otherProfileOwnerGifs.count
                                        : viewModel.ownProfileFavouritedGifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let viewModel = viewModel else { return UICollectionViewCell()}
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(GiphyCell.self)", for: indexPath) as! GiphyCell
        
        if viewModel.type == .other {
            cell.viewModel = GiphyCellViewModel(items: viewModel.otherProfileOwnerGifs[indexPath.row])
        } else {
            cell.viewModel = GiphyCellViewModel(items: viewModel.ownProfileFavouritedGifs[indexPath.row])
        }
        return cell
    }
}
