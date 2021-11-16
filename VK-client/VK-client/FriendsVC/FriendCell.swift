//
//  FriendCell.swift
//  VK-client
//
//  Created by Artem Firsov on 10/18/21.
//

import UIKit
import SDWebImage

class FriendCell: UITableViewCell {

    static let reuseIden = "FriendCell"
    
    var user: User! {
        didSet {
            nameLabel.text = user.first_name + " " + user.last_name
            guard let url = URL(string: user.photo_50) else { return }
            photoImage.sd_setImage(with: url, placeholderImage: UIImage())

        }
    }
    
    var group: Group! {
        didSet {
            nameLabel.text = group.name
            guard let url = URL(string: group.photo_50) else { return }
            photoImage.sd_setImage(with: url, placeholderImage: UIImage())
        }
    }
    
    private var viewForImage: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = view.frame.height * 0.5
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOpacity = 0.7
//        view.layer.shadowRadius = 5
//        view.layer.shadowOffset = .zero
        return view
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private var photoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = image.frame.height * 0.5
        image.clipsToBounds = false
        return image
    }()
    
    private func setupConstraints() {
        addSubview(nameLabel)
        addSubview(viewForImage)
        viewForImage.addSubview(photoImage)
        
        let aspectRatio = NSLayoutConstraint(item: viewForImage, attribute: .width, relatedBy: .equal, toItem: viewForImage, attribute: .height, multiplier: 1/1, constant: 0)
        viewForImage.addConstraint(aspectRatio)
        NSLayoutConstraint.activate([
                                        viewForImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
                                        viewForImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
                                        viewForImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),
                                        photoImage.topAnchor.constraint(equalTo: viewForImage.topAnchor),
                                        photoImage.leadingAnchor.constraint(equalTo: viewForImage.leadingAnchor),
                                        photoImage.trailingAnchor.constraint(equalTo: viewForImage.trailingAnchor),
                                        photoImage.bottomAnchor.constraint(equalTo: viewForImage.bottomAnchor),
                                        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                        nameLabel.leadingAnchor.constraint(equalTo: photoImage.trailingAnchor, constant: 10),
                                        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)])
        
    }
    
    func configure() {
       setupConstraints()
        viewForImage.layer.cornerRadius = viewForImage.frame.height * 0.5
        viewForImage.layer.shadowColor = UIColor.black.cgColor
        viewForImage.layer.shadowOpacity = 0.7
        viewForImage.layer.shadowRadius = 5
        viewForImage.layer.shadowOffset = .zero
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func clearCell() {
        nameLabel.text = nil
        photoImage.image = nil
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
}
