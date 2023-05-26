//  GiphyDetailController.swift
//  Giphy
//  Created by Erkan Emir on 17.05.23.

import UIKit
import SDWebImage
import Photos
class GiphyDetailController: UIViewController {
    
    //MARK: - Properties
    var viewModel: GiphyDetailViewModel? {
        didSet {
            configure()
            collection.reloadData()
        }
    }
    
    private lazy var giphyImageView: UIImageView =  {
        let iv = UIImageView()
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        longGesture.numberOfTouchesRequired = 1
        longGesture.allowableMovement = 10
        longGesture.minimumPressDuration = 1
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(single))

        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedFavouriteButton))
        doubleTapGesture.numberOfTapsRequired = 2
    
        singleTapGesture.require(toFail: doubleTapGesture)
        singleTapGesture.delaysTouchesBegan = true
        doubleTapGesture.delaysTouchesBegan = true
        
        iv.addGestureRecognizer(longGesture)
        iv.addGestureRecognizer(doubleTapGesture)
        iv.addGestureRecognizer(singleTapGesture)
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
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
    
    private lazy var favouriteButton: UIButton = {
        let iv = UIButton()
        iv.addTarget(self, action: #selector(tappedFavouriteButton), for: .touchUpInside)
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
        configFavouriteButton()
    }
    
    //MARK: - Actions
    
    @objc func single() { }

    private func configFavouriteButton() {
        viewModel?.checkGifsIfFavourite(completion: { isFavourite in
            
            isFavourite ? self.favouriteButton.setImage(UIImage(named:  "favourite" ),for: .normal)
                        : self.favouriteButton.setImage(UIImage(named: "unFavourite"),for: .normal)
        })
    }
    
    @objc fileprivate func longPressed() {
        guard let image = giphyImageView.image else { return }
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Save To Camera Roll",
                                      style: .default,
                                      handler: { _ in
            self.showLoader(true)
            UIImageWriteToSavedPhotosAlbum(image , self, #selector(self.imagee(_:didFinishSavingWithError:contextInfo:)), nil)
            self.showLoader(false)

        }))

        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .default,
                                      handler: nil))
        
        present(alert, animated: true, completion: nil)

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
        
        let controller = AccountController()
        controller.viewModel = AccountViewModel(items: viewModel.items,type: .other)
        navigationController?.show(controller, sender: nil)
    }
    
    // MARK:- Helper
    
    @objc func imagee(_ image: UIImage, didFinishSavingWithError error: Error?,contextInfo: UnsafeRawPointer) {
        if  error != nil { print("\(error?.localizedDescription)")}

    }
    
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
        favouriteButton.setDimensions(height: 36, width: 36)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: stack.bottomAnchor,left: view.leftAnchor,paddingTop: 20,paddingLeft: 4)
        
        view.addSubview(collection)
        collection.anchor(top: titleLabel.bottomAnchor,left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingTop: 4,paddingLeft: 2,paddingBottom: 0,paddingRight: 2)
    }
    
    func configure() {
        guard let gifURL = viewModel?.gifURL else { return }
        print(gifURL)
        guard let userPhotoURL = viewModel?.userNamePhotoURL else { return }
        
        giphyImageView.setGifFromURL(gifURL)
        userNamePhoto.sd_setImage(with: userPhotoURL)
        userNameLabel.text = viewModel?.userNameText
        displayNameLabel.text = viewModel?.displayNameText
    }
}

extension GiphyDetailController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

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
