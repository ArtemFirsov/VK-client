//
//  CodedTopCell.swift
//  VK-client
//
//  Created by Artem Firsov on 11/1/21.
//

import UIKit

class CodedTopCell: UITableViewCell {
    
    let cardView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return view
    }()
    
    let avatarView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "heart.fill")
        return imageView
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "test name"
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    let dateLabel: UILabel = {
       let label = UILabel()
        label.text = "test data"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private func setupConstraints() {
        contentView.addSubview(cardView)
        cardView.addSubview(nameLabel)
        cardView.addSubview(dateLabel)
        cardView.addSubview(avatarView)

        
        cardView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        avatarView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 2).isActive = true
        avatarView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -2).isActive = true
        avatarView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 2).isActive = true
        let aspectRatio = NSLayoutConstraint(item: avatarView, attribute: .height, relatedBy: .equal, toItem: avatarView, attribute: .width, multiplier: 1/1, constant: 0)
        avatarView.addConstraint(aspectRatio)
        
        nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 2).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: avatarView.heightAnchor, multiplier: 1/2).isActive = true
        
        dateLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 2).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 8).isActive = true

        
    }
    
    
    static let reuseIden = "CodedTopCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
