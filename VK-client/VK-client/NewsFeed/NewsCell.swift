//
//  NewsCell.swift
//  VK-client
//
//  Created by Artem Firsov on 10/19/21.
//

import UIKit



class NewsCell: UICollectionViewCell {
    
    static let reuseIden = "NewsCell"
    
    var userInfo: Profile! {
        didSet {
            postStarterName.text = "sad"
        }
    }
    
    var postInfo: News! {
        didSet {
            postDescription.text = postInfo.text
            let some = postInfo.attachments.map { (attach) in
                attach.map { (some) in
                    some.photo?.sizes.map({ (sizes) in
                        print(sizes.url)
                    })
                }
            }
            
        }
    }
    
    private let postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let avatarImage: UIImageView = {
        let avatar = UIImageView()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.clipsToBounds = true
        avatar.contentMode = .scaleAspectFill
        
        return avatar
    }()
    
    private let postStarterName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let postDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    private func clearCell() {
        postStarterName.text = nil
        avatarImage.image = nil
        postDescription.text = nil
    }
}
