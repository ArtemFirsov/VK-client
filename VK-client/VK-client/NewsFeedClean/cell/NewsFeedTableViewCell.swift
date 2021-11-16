//
//  NewsFeedTableViewCell.swift
//  VK-client
//
//  Created by Artem Firsov on 11/1/21.
//

import UIKit

protocol FeedCellViewModel {
    var name: String { get }
    var date: String { get }
    var postText: String? { get }
    var likes: String? { get }
    var views: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var avatarImageUrl: String { get }
    var postImage: FeedCellPostImage? { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellPostImage {
    var postPhotoUrl: String? { get }
    var width: Int { get }
    var height: Int { get }
}

protocol FeedCellSizes {
    var postLabelSize: CGRect { get }
    var postImageSize: CGRect { get }
    var bottomView: CGRect { get }
    var topView: CGRect { get }
    var totalHeight: CGFloat { get }
}

class NewsFeedTableViewCell: UITableViewCell {
    
    static let reuseIden = "NewsFeedTableViewCell"

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImage: WebImageView!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var postImage: WebImageView!
    @IBOutlet weak var bottomView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(viewModel: FeedCellViewModel) {
        avatarImage.configure(imageUrl: viewModel.avatarImageUrl)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postTextLabel.text = viewModel.postText
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        shareLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        postTextLabel.frame = viewModel.sizes.postLabelSize
        postImage.frame = viewModel.sizes.postImageSize
        bottomView.frame = viewModel.sizes.bottomView
        if let attachment = viewModel.postImage {
            postImage.configure(imageUrl: attachment.postPhotoUrl)
            postImage.isHidden = false
        } else {
            postImage.isHidden = true
        }
        
        avatarImage.layer.cornerRadius = avatarImage.frame.size.height / 2
        cardView.layer.cornerRadius = 8
        selectionStyle = .none
    }
    
    private func clearCell() {
        dateLabel.text = nil
        postTextLabel.text = nil
        nameLabel.text = nil
        likesLabel.text = nil
        viewsLabel.text = nil
        shareLabel.text = nil
        commentsLabel.text = nil
        postImage.image = nil
        avatarImage.image = nil
    }
    
    override func prepareForReuse() {
        clearCell()
    }
}
