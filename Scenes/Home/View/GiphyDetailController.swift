//  GiphyDetailController.swift
//  Giphy
//  Created by Erkan Emir on 17.05.23.

import UIKit
import SDWebImage
import Photos

class GiphyDetailController: UIViewController {
    
    //MARK: - Properties
    var coordinator: AppCoordinator? 
    
    var viewModel: GiphyDetailViewModel? {
        didSet {
            configure()
            collection.reloadData()
        }
    }
    
    private let gifImageView    = UIImageView()
    private let userImageView   = UIImageView()
    private let favouriteButton = UIButton()

    private let userNameLabel    = CustomLabel(text: "",
                                            size: 14)
    private let displayNameLabel = CustomLabel(text: "",
                                               size: 14)
    private let collectionLabel  = CustomLabel(text: "Related GIFs",
                                         size: 16)
    
    private lazy var collection: UICollectionView = {
        let l = PinterestLayout()
        l.numberOfColumns = 2
        l.delegate = self
        
        let c = UICollectionView(frame: .zero, collectionViewLayout: l)
        c.register(GiphyCell.self,
                   forCellWithReuseIdentifier: "\(GiphyCell.self)")
        c.delegate   = self
        c.dataSource = self
        return c
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationController()

        viewModel?.fetchRelatedGifs()
        viewModel?.succesCallBack = { self.collection.reloadData() }
        
    }

    // MARK:- Helper
    func configureUI() {
        configureGiphyImageView()
        configureUserNameImageView()
        configureUserDetail()
        configureButtons()
        configureCollection()
    }
    
    func configureNavigationController() {
        
//        guard let nav = tabBarController?.viewControllers![0] as? UINavigationController else { return }
        guard let nav = navigationController else { return }
        coordinator = AppCoordinator(navigationController: nav)
        }
    
    private func configureGiphyView() {
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        longGesture.numberOfTouchesRequired = 1
        longGesture.allowableMovement = 10
        longGesture.minimumPressDuration = 1
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: nil)

        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedFavouriteButton))
        doubleTapGesture.numberOfTapsRequired = 2
    
        singleTapGesture.require(toFail: doubleTapGesture)
        singleTapGesture.delaysTouchesBegan = true
        doubleTapGesture.delaysTouchesBegan = true
        
        gifImageView.addGestureRecognizer(longGesture)
        gifImageView.addGestureRecognizer(doubleTapGesture)
        gifImageView.addGestureRecognizer(singleTapGesture)
        gifImageView.isUserInteractionEnabled = true
    }
    
    private func configureGiphyImageView() {
        view.addSubview(gifImageView)
        gifImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,
                              right: view.rightAnchor,
                              paddingTop: 4,paddingLeft: 24,paddingRight: 24)
        gifImageView.setHeight(180)
        
        configureGiphyView()
    }
    
    private func configureUserNameImageView() {
        view.addSubview(userImageView)
        userImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAccount)))
        userImageView.isUserInteractionEnabled = true
        userImageView.anchor(top: gifImageView.bottomAnchor,left: view.leftAnchor,paddingTop: 8,paddingLeft: 24)
        userImageView.setDimensions(height: 48, width: 48)
        
    }
    
    private func configureUserDetail() {
        let stack = UIStackView(arrangedSubviews: [userNameLabel,
                                                   displayNameLabel])
        
        userNameLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAccount)))
        userNameLabel.isUserInteractionEnabled = true
        
        displayNameLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAccount)))
        displayNameLabel.isUserInteractionEnabled = true
        
        view.addSubview(stack)
        stack.axis = .vertical
        userNameLabel.textAlignment = .left
        displayNameLabel.textAlignment = .left
        
        stack.anchor(top: gifImageView.bottomAnchor,left: userImageView.rightAnchor,paddingTop: 8,paddingLeft: 4)
        stack.setDimensions(height: 48, width: view.frame.width)
        
        view.addSubview(collectionLabel)
        collectionLabel.anchor(top: stack.bottomAnchor,left: view.leftAnchor,paddingTop: 20,paddingLeft: 4)
    }
    
    private func configureCollection() {
        view.addSubview(collection)
        collection.backgroundColor = .black
        collection.anchor(top: collectionLabel.bottomAnchor,left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingTop: 4,paddingLeft: 2,paddingBottom: 0,paddingRight: 2)
    }
    
    private func configureButtons() {
        view.addSubview(favouriteButton)
        favouriteButton.addTarget(self, action: #selector(tappedFavouriteButton), for: .touchUpInside)

        favouriteButton.anchor(top: gifImageView.bottomAnchor,right: view.rightAnchor,paddingTop: 8,paddingRight: 28)
        favouriteButton.setDimensions(height: 36, width: 36)
        
        configFavouriteButton()
    }

    private func configure() {
//        guard let gifURL = viewModel?.gifURL else { return }
//        guard let userPhotoURL = viewModel?.userNamePhotoURL else { return }
        userNameLabel.text = viewModel?.userNameText
        displayNameLabel.text = viewModel?.displayNameText
        
        setGifFromURL(imageView: gifImageView,
                      url: (viewModel?.gifURL ?? URL(string: ""))!)
        userImageView.sd_setImage(with: viewModel?.userNamePhotoURL ?? URL(string: ""))
  
    }
    
    //MARK: - Actions
    
    private func configFavouriteButton() {
        viewModel?.checkGifsIfFavourite(completion: { isFavourite in
            
            isFavourite ? self.favouriteButton.setImage(UIImage(named:  "favourite" ),for: .normal)
                        : self.favouriteButton.setImage(UIImage(named: "unFavourite"),for: .normal)
        })
    }
    
    @objc private func longPressed() {
        guard let image = gifImageView.image else { return }

        showMessageActionSheet(title: "Save To Camera Roll") {
            self.showLoader(true)
            UIImageWriteToSavedPhotosAlbum(image , self, #selector(self.imagee(_:didFinishSavingWithError:contextInfo:)), nil)
            self.showLoader(false)
        }
    }
    
    @objc fileprivate func tappedFavouriteButton() {
        guard let viewModel = viewModel              else { return }
        guard let gifURL    = viewModel.gifURL       else { return }
        guard let gifID     = viewModel.items.gifID_ else { return }

        if viewModel.isFavourite {
            favouriteButton.setImage(UIImage(named: "unFavourite"), for: .normal)
            FavouriteManager.unFavouriteGif(gifID: gifID)
        } else {
            favouriteButton.setImage(UIImage(named: "favourite"), for: .normal)
            FavouriteManager.favouriteGif(gifID: gifID, gifURL: "\(gifURL)")
        }
        
        viewModel.isFavourite.toggle()
    }
    
    @objc fileprivate func showAccount() {
        guard let viewModel = viewModel else { return }
        
        coordinator?.showAccount(items: viewModel.items, type: .other)
    }
    
    @objc func imagee(_ image: UIImage,
                      didFinishSavingWithError error: Error?,
                      contextInfo: UnsafeRawPointer) {
        if error != nil { return }
    }
}

//MARK: - UICollectionViewDelegate
extension GiphyDetailController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let relatedItems = viewModel?.relatedItems else { return }
        
        coordinator?.showGiphyDetail(items: relatedItems[indexPath.row])
    }
}

//MARK: - UICollectionViewDataSource
extension GiphyDetailController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel?.relatedItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(GiphyCell.self)",
                                                  for: indexPath) as! GiphyCell
        
        cell.viewModel = GiphyCellViewModel(items: (viewModel?.relatedItems[indexPath.row])!)
        
        return cell
    }
}

//MARK: - PinterestLayoutDelegate
extension GiphyDetailController: PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView,
                        heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let random = arc4random_uniform(3) + 1
        return CGFloat(random * 100)
    }
}
