//  FeedController.swift
//  Giphy
//  Created by Erkan Emir on 13.05.23.

import UIKit
import FirebaseAuth
import GiphyUISDK

class PageViewController: UIPageViewController {
    
    var myControllers = [UIViewController]()
    
    //MARK: - Properties
//    let giphy = GiphyViewController()
    
    private lazy var segmentControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Red","Blue","Green"])
        sc.addTarget(self, action: #selector(segmentControlSwipe), for: .valueChanged)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    @objc fileprivate func segmentControlSwipe(sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        switch sender.selectedSegmentIndex {
        case 0:
            self.setViewControllers([myControllers[0]], direction: .forward, animated: false)
        case 1:
            self.setViewControllers([myControllers[1]], direction: .forward, animated: false)
        case _:
            self.setViewControllers([myControllers[2]], direction: .forward, animated: false)
        }
    }
//    private lazy var pageControl: UIPageControl = {
//        let pc = UIPageControl()
////        pc.numberOfPages = 5
////        pc.currentPage = 3
////        pc.addTarget(self, action: #selector(aaa), for: .touchUpInside)
//        return pc
//    }()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle,
                  navigationOrientation: UIPageViewController.NavigationOrientation,
                  options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        configureNav()
        configureUI()
        configureViewControllers()
    }
    
    private func configureViewControllers() {
        let vc = SearchController()
        myControllers.append(vc)
        
        let vc2 = SearchController()
        vc2.view.backgroundColor = .blue
        myControllers.append(vc2)
        
        let vc3 = SearchController()
        vc3.view.backgroundColor = .green
        myControllers.append(vc3)
        
        guard let first = myControllers.first else { return }
//        pageControl.numberOfPages = myControllers.count
        self.setViewControllers([first], direction: .forward, animated: false)
    }
    
    
    //MARK: - Actions
    
    @objc private func tappedLogOutButton() {
        do {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav , animated: false)
            
            try Auth.auth().signOut()
            
        } catch { print("DEBUG: Error") }
    }
    
    //    @objc func aaa(sender: UIPageControl) {
    //        print(sender.currentPage)
    //    }

    //MARK: - Helpers
    private func configureNav() {
        let leftButton = UIBarButtonItem(title: "Log out", style: .done, target: self, action: #selector(tappedLogOutButton))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    private func configureUI() {
//        addChild(giphy)
//        giphy.mediaTypeConfig = [.gifs, .stickers, .text, .emoji]
//        giphy.theme = GPHTheme(type: .darkBlur)
//        view.addSubview(giphy.view)
        
        view.addSubview(segmentControl)
        segmentControl.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 12,paddingLeft: 8,paddingRight: 8)
        segmentControl.setHeight(40)
        
//        view.addSubview(pageControl)
//        pageControl.anchor(left: view.leftAnchor,
//                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
//                           right: view.rightAnchor,paddingLeft: 8,
//                           paddingBottom: 24,paddingRight: 8)
//        pageControl.setHeight(80)
        
    }
    
}

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print("aa")
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let index = myControllers.firstIndex(of: viewControllers[0]) else { return }
        
        segmentControl.selectedSegmentIndex = index
//        pageControl.currentPage = index

    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController) , index > 0 else { return nil }
        let before = index - 1
        
        return myControllers[before]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController) , index < (myControllers.count - 1) else { return nil }
        
        let after = index + 1
        
        return myControllers[after]
    }
    
    
}
