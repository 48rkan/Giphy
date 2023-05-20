//  GiphyDetailController.swift
//  Giphy
//  Created by Erkan Emir on 17.05.23.

import UIKit
import SDWebImage

class GiphyDetailController: UIViewController {
    
    //MARK: - Properties
    
    var viewModel: GiphyDetailViewModel? {
        didSet {
            configure()
            collection.reloadData()
        }
    }
    
    private let giphyImageView = UIImageView()
    
    private lazy var userNamePhoto: UIImageView = {
        let iv = UIImageView()
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAccount)))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let userNameLabel = CustomLabel(text: "MotoGP",
                                            size: 14)
    
    private let displayNameLabel = CustomLabel(text: "@motoGP",
                                               size: 14)
    
    private let favouriteButton: UIButton = {
        let iv = UIButton()
        iv.setImage(.add, for: .normal)
        
        return iv
    }()
    
    private let titleLabel = CustomLabel(text: "Related GIFs",
                                         size: 16)
    
    private lazy var collection: UICollectionView = {
        let l = PinterestLayout()
        l.numberOfColumns = 2
        l.delegate = self
        
        let c = UICollectionView(frame: .zero, collectionViewLayout: l)
        
        c.register(GiphyCell.self,
                   forCellWithReuseIdentifier: "\(GiphyCell.self)")
        
        c.register(GiphyDetailHeader.self,
                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                   withReuseIdentifier: "\(GiphyDetailHeader.self)")
        c.delegate   = self
        c.dataSource = self
        c.backgroundColor = .black
        return c
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        viewModel?.fetchRelatedGifs()
        viewModel?.succesCallBack = { self.collection.reloadData() }
    }
    

    
    //MARK: - Actions
    @objc fileprivate func showAccount() {
        guard let viewModel = viewModel else { return }
        
        let controller = AccountController()
        controller.viewModel = AccountViewModel(items: viewModel.items)
        navigationController?.show(controller, sender: nil)
    }
    
    // MARK:- Helper
    func configureUI() {
        view.addSubview(giphyImageView)
        giphyImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 4,paddingLeft: 24,paddingRight: 24)
        giphyImageView.setHeight(180)
        
        view.addSubview(userNamePhoto)
        userNamePhoto.anchor(top: giphyImageView.bottomAnchor,left: view.leftAnchor,paddingTop: 8,paddingLeft: 24)
        userNamePhoto.setDimensions(height: 48, width: 48)
        
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

        stack.anchor(top: giphyImageView.bottomAnchor,left: userNamePhoto.rightAnchor,paddingTop: 8,paddingLeft: 4)
        stack.setDimensions(height: 48, width: view.frame.width)
        
        view.addSubview(favouriteButton)
        favouriteButton.anchor(top: giphyImageView.bottomAnchor,right: view.rightAnchor,paddingTop: 8,paddingRight: 28)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: stack.bottomAnchor,left: view.leftAnchor,paddingTop: 20,paddingLeft: 4)
        
        view.addSubview(collection)
        collection.anchor(top: titleLabel.bottomAnchor,left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingTop: 4,paddingLeft: 2,paddingBottom: 0,paddingRight: 2)
    }
    
    func configure() {
        guard let gifURL = viewModel?.gifURL else { return }
        guard let userPhotoURL = viewModel?.userNamePhotoURL else { return }
        
        giphyImageView.setGifFromURL(gifURL,levelOfIntegrity: .highestNoFrameSkipping)
        userNamePhoto.sd_setImage(with: userPhotoURL)
        userNameLabel.text = viewModel?.userNameText
        displayNameLabel.text = viewModel?.displayNameText
    }
}

extension GiphyDetailController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        let controller = GiphyDetailController()
        controller.viewModel = GiphyDetailViewModel(items: (viewModel?.relatedItems[indexPath.row])!)
        navigationController?.show(controller, sender: nil)
        
    }
}

extension GiphyDetailController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.relatedItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(GiphyCell.self)", for: indexPath) as! GiphyCell
        cell.viewModel = GiphyCellViewModel(items: (viewModel?.relatedItems[indexPath.row])!)
        return cell
    }
}

//MARK: - PinterestLayoutDelegate

extension GiphyDetailController: PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let random = arc4random_uniform(3) + 1
        return CGFloat(random * 100)
    }
}
