//
//  SizeCalculator.swift
//  VK-client
//
//  Created by Artem Firsov on 11/10/21.
//

import UIKit

protocol SizeCalculatorProtocol {
    func sizes(postText: String?, postImage: FeedCellPostImage?) -> FeedCellSizes
}

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight: CGFloat = 40
    static let postLabelInsets = UIEdgeInsets(top: Constants.topViewHeight + 8 , left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
}

class SizeCalculator: SizeCalculatorProtocol {
    
    
    
    func sizes(postText: String?, postImage: FeedCellPostImage?) -> FeedCellSizes {
        
        var postImageFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize.zero)
        
        if let image = postImage, image.height != 0, image.width != 0 {
            let imageWidth: Float = Float(image.width)
            let imageHeight: Float = Float(image.height)
            let aspectRatio = imageHeight / imageWidth

            postImageFrame.size = CGSize(width: screenWidth, height: screenWidth * CGFloat(aspectRatio))
//            postImageFrame.size = CGSize(width: image.width, height: image.height)
        }
        
        
        
        
        let topViewFrame = CGRect(x: 0, y: 0, width: screenWidth, height: 40)
        let bottomViewFrame = CGRect(x: 0, y: postImageFrame.maxY + 3, width: screenWidth, height: 44)
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            let height = text.height(width: width, font: Constants.postLabelFont)
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        return Sizes(topView: topViewFrame,
                     bottomView: bottomViewFrame,
                     totalHeight: postImageFrame.height + postLabelFrame.height + topViewFrame.height + bottomViewFrame.height + 20,
                     postLabelSize: postLabelFrame,
//                     postImageSize: CGRect.zero)
                     postImageSize: postImageFrame)
    }
    
    struct Sizes: FeedCellSizes {
        var topView: CGRect
        var bottomView: CGRect
        var totalHeight: CGFloat
        var postLabelSize: CGRect
        var postImageSize: CGRect
    }
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    
}
