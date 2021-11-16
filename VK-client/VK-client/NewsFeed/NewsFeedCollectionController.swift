//
//  NewsFeedViewController.swift
//  VK-client
//
//  Created by Artem Firsov on 10/19/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class NewsFeedCollectionController: UICollectionViewController {

    var newsPosts: [News] = []
    var newsGroups: [Group] = []
    var newsProfiles: [Profile] = []
    
    let apiService = ApiService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        self.collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.reuseIden)
        setupCompositionalLayout()
        
        DispatchQueue.main.async {
            self.apiService.getNews { [weak self] posts, groups, profiles in
                guard let self = self else { return }
                self.newsPosts = posts
                self.newsGroups = groups ?? []
                self.newsProfiles = profiles ?? []
                self.collectionView.reloadData()
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return newsPosts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.reuseIden, for: indexPath) as? NewsCell else { return UICollectionViewCell()}
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .red
        let post = newsPosts[indexPath.item]
        cell.postInfo = post
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(newsPosts.count, newsGroups.count, newsProfiles.count)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension NewsFeedCollectionController {
    
    func setupCompositionalLayout() {
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 16, trailing: 10)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
        
    }
}
