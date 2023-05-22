//  HomeController.swift
//  Giphy
//  Created by Erkan Emir on 15.05.23.

import UIKit
import FirebaseAuth

class HomeController: UIViewController {
    
    //MARK: - Properties
    var viewModel = HomeViewModel()
    
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
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        
        viewModel.getGifs(type: .trending)
        viewModel.successCallBack = {
            self.showLoader(false)
            self.collection.reloadData()
        }
    }
    
    //MARK: - Actions
    
    @objc private func tappedLogOutButton() {
        do {
            let controller = LoginController()
            controller.delegate = tabBarController as? MainTabBarController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav , animated: false)
            
            try Auth.auth().signOut()
            
        } catch { print("DEBUG: Error") }
    }
    
    //MARK: - Helper

    func configureUI() {
        view.addSubview(customView)
        customView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor, right: view.rightAnchor,
                          paddingTop: 8, paddingLeft: 8, paddingRight: 4)
        customView.setHeight(56)
        
        view.addSubview(collection)
        collection.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,
                          bottom: view.bottomAnchor,
                          right: view.rightAnchor,paddingTop: 72,
                          paddingLeft: 4,paddingBottom: 0,
                          paddingRight: 4)
    }
    
    func configureNavigationBar() {
        //Left Bar Button Item
        let button = UIButton(type: .custom)
        button.imageView?.contentMode = .scaleAspectFill
        button.setImage(UIImage(named: "giphy"), for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        button.setDimensions(height: 40, width: 120)
        
        //Right Bar Button Item(s)
        let buttonTwo = UIButton(type: .custom)
        buttonTwo.setImage(UIImage(named: "addLogo"), for: .normal)
        buttonTwo.imageView?.contentMode = .scaleAspectFill
        
        let logOutButton = UIBarButtonItem(title: "Log out", style: .done, target: self, action: #selector(tappedLogOutButton))

        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: buttonTwo),logOutButton]
        buttonTwo.setDimensions(height: 36, width: 36)
    }
}

//MARK: - UICollectionViewDelegate

extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = GiphyDetailController()
        controller.viewModel = GiphyDetailViewModel(items: viewModel.items[indexPath.row])
        navigationController?.show(controller, sender: nil)
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

import SwiftUI

struct MainPreview: PreviewProvider {
    
    static var previews: some View {
        ContainView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            UINavigationController(rootViewController: HomeController())
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
