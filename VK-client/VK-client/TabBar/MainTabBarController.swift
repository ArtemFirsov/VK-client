//
//  MainTabBarController.swift
//  VK-Client
//
//  Created by Artem Firsov on 10/16/21.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }

    private let middleItemDiameter: CGFloat = 42
    
    private lazy var middleButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = middleItemDiameter / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        return button
    }()
    
    @objc func didPressButton() {
        selectedIndex = 1
    }
    
    private lazy var imageForButton: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(systemName: "newspaper.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .white
        return image
    }()
    
    private func makeUI() {
        tabBar.addSubview(middleButton)
        middleButton.addSubview(imageForButton)
        
        
        NSLayoutConstraint.activate([
                                        middleButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
                                        middleButton.heightAnchor.constraint(equalToConstant: middleItemDiameter),
                                        middleButton.widthAnchor.constraint(equalToConstant: middleItemDiameter),
                                        middleButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -10)])
        
        NSLayoutConstraint.activate([
                                        imageForButton.widthAnchor.constraint(equalToConstant: 18),
                                        imageForButton.heightAnchor.constraint(equalToConstant: 18),
                                        imageForButton.centerXAnchor.constraint(equalTo: middleButton.centerXAnchor),
                                        imageForButton.centerYAnchor.constraint(equalTo: middleButton.centerYAnchor)])
        
        let firstVC = FriendsViewController()
        firstVC.tabBarItem.title = "Friends"
        firstVC.tabBarItem.image = UIImage(systemName: "1.circle")

        // 2
//        let middleVC = NewsFeedCollectionController(collectionViewLayout: UICollectionViewFlowLayout())
        let middleVC = NewsFeedViewController()
//        storyboard?.instantiateViewController(identifier: "NewsFeedController")
        middleVC.tabBarItem.title = "Middle VC"

        // 3
        let secondVC = GroupsViewController()
        secondVC.tabBarItem.title = "Groups"
        secondVC.tabBarItem.image = UIImage(systemName: "2.circle")

        // 4
        viewControllers = [firstVC, middleVC, secondVC]
        
    }
    
    
    
    

}

