//
//  CodedMiddleCell.swift
//  VK-client
//
//  Created by Artem Firsov on 11/1/21.
//

import UIKit

class CodedMiddleCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        contentView.addSubview(cardView)
        cardView.addSubview(postTextLabel)
        cardView.addSubview(postImage)
        
        cardView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        postTextLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        postTextLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5).isActive = true
        postTextLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 8).isActive = true
        postTextLabel.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
    }
    
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let postTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    let postImage: UIImageView = { //WebImageView
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "heart")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightText
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
