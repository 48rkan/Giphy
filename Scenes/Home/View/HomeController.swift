//  HomeController.swift
//  Giphy
//  Created by Erkan Emir on 15.05.23.

import UIKit
import FirebaseAuth
import AVFoundation

class HomeController: UIViewController {
    
    //MARK: - Properties
    var viewModel = HomeViewModel()
    
    var coordinator: AppCoordinator?
    
    private lazy var customView: CollectionInUIView = {
        let cv = CollectionInUIView()
        cv.delegate = self
        return cv
    }()
    
    private lazy var collection: UICollectionView = {
        let l = PinterestLayout()
        l.numberOfColumns = 2
        l.delegate = self
        
        let c = UICollectionView(frame: .zero, collectionViewLayout: l)
        c.register(GiphyCell.self, forCellWithReuseIdentifier: "\(GiphyCell.self)")
        c.backgroundColor = .black
        c.delegate   = self
        c.dataSource = self

        return c
    }()
    
    private var nvActivityIndicator : UIActivityIndicatorView?
    
    private var collectionTopAnchor = NSLayoutConstraint()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        configRefreshController()
        addNavToCoordinator()
        
//        SoundHandler.playSound(name: "welcome", type: "mp3")

        viewModel.getGifs(type: .trending)
        viewModel.successCallBack = {
            self.showLoader(false)
            self.collection.reloadData()
            self.collection.refreshControl?.endRefreshing()
            
            UIView.animate(withDuration: 3) {
                self.collectionTopAnchor.constant = 72
                self.view.layoutIfNeeded()
            }
        }
    }

    //MARK: - Actions
    
    @objc private func tappedLogOutButton() {
        do {
            coordinator?.showLogOut(tabBar: (tabBarController as? MainTabBarController)!)
        
            try Auth.auth().signOut()
            
        } catch { print("DEBUG: Error") }
    }
    
    //MARK: - Helper
    

    
    private func configureUI () {
        view.addSubview(customView)
        customView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor, right: view.rightAnchor,
                          paddingTop: 8, paddingLeft: 8, paddingRight: 4)
        customView.setHeight(56)
        
        view.addSubview(collection)
        collection.anchor(left: view.leftAnchor,
                          bottom: view.bottomAnchor,
                          right: view.rightAnchor,
                          paddingLeft: 4,paddingBottom: 0,
                          paddingRight: 4)
        collectionTopAnchor = collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                              constant: 72)
        collectionTopAnchor.isActive = true
    }
    
    private func configureNavigationBar() {
        //Left Bar Button Item
        let button = UIButton(type: .custom)
        button.imageView?.contentMode = .scaleAspectFill
        button.setImage(UIImage(named: "giphy"), for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        button.setDimensions(height: 40, width: 120)
        
        //Right Bar Button Item(s)
        let buttonTwo = UIButton(type: .custom)
        buttonTwo.addTarget(self,
                            action: #selector(tappedButtonTwo),
                            for: .touchUpInside)
        buttonTwo.setImage(UIImage(named: "addLogo"), for: .normal)
        buttonTwo.imageView?.contentMode = .scaleAspectFill
        
        let logOutButton = UIBarButtonItem(title: "Log out".localize,
                                           style: .done,
                                           target: self,
                                           action: #selector(tappedLogOutButton))

        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: buttonTwo),logOutButton]
        buttonTwo.setDimensions(height: 36, width: 36)
    }
    
    private func addNavToCoordinator() {
        guard let nav = navigationController else { return }
        coordinator = AppCoordinator(navigationController: nav)
    }
    
    private func configRefreshController() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshing), for: .valueChanged)
        self.collection.refreshControl = refreshControl
        self.collection.refreshControl?.tintColor = .white
        
        let refreshImage      = UIImageView()
        setGifFromURL(imageView: refreshImage,
                      url: URL(string: "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExNDIxZmEyOTNjNzQ5MDYxNzk4ZTYyOWY0MzIyYTU4ZDJjNWQyMThiOCZlcD12MV9pbnRlcm5hbF9naWZzX2dpZklkJmN0PWc/xTkcEQACH24SMPxIQg/giphy.gif")!)
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor       = UIColor.clear
        refreshControl.addSubview(refreshImage)
        
        refreshImage.frame = refreshControl.bounds.offsetBy(
            dx: view.frame.width / 2 - 20,
            dy: 0)
        refreshImage.frame.size.width  = 60
        refreshImage.frame.size.height = 60
        
        collection.addSubview(refreshControl)
    }
        
    @objc func refreshing() {
        nvActivityIndicator?.startAnimating()
        
        UIView.animate(withDuration: 3) {
            self.collectionTopAnchor.constant = 160
//            self.view.layoutIfNeeded()
        }
        
        viewModel.getGifs(type: viewModel.currentSituation.0,
                          query: viewModel.currentSituation.1)
        
    }
    
    @objc func tappedButtonTwo() {
        let controller = LanguageController()
        presentPanModal(controller)
    }
}

//MARK: - UICollectionViewDelegate
extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        coordinator?.showGiphyDetail(items: viewModel.items[indexPath.row])
    }
}

//MARK: - UICollectionViewDataSource
extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(GiphyCell.self)", for: indexPath) as! GiphyCell
        cell.viewModel = GiphyCellViewModel(items: viewModel.items[indexPath.row])
        
        return cell
    }
}

//MARK: - CustomViewDelegate
extension HomeController: CustomViewDelegate {
    func category(_ name: String) {
        showLoader(true)
        collection.scrollToItem(at: IndexPath(item: self.viewModel.items.count - 1, section: 0),
                                at: .centeredVertically,
                                animated: true)
        
        viewModel.getGifs(type: GifsType(rawValue: name) ?? .trending,
                          query: name)
        viewModel.currentSituation = (GifsType(rawValue: name) ?? .trending,name)
        collection.reloadData()
    }
}

//MARK: - PinterestLayoutDelegate
extension HomeController: PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let random = arc4random_uniform(3) + 1
        return CGFloat(random * 100)
    }
}

//import SwiftUI
//
//struct MainPreview: PreviewProvider {
//
//    static var previews: some View {
//        ContainView().edgesIgnoringSafeArea(.all)
//    }
//
//    struct ContainView: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> some UIViewController {
//            UINavigationController(rootViewController: MainTabBarController())
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
//    }
//}
