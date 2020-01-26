//
//  BeerCell.swift
//  BeersTestApp
//
//  Created by Roman Rybachenko on 24.01.2020.
//  Copyright © 2020 Roman Rybachenko. All rights reserved.
//

import UIKit

class BeerCell: UITableViewCell, ReusableCell {
    
    // MARK: - Outlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagilneLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    // MARK: - Properties
    static var height: CGFloat {
        return Constants.minimumHeight
    }

    
    // MARK: - Overriden funcs
    override func awakeFromNib() {
        super.awakeFromNib()
        
        logoImageView.setCornerRadius(Constants.imageViewCornerRadius)
    }
    
//    // MARK: - Static funcs
//    
//    static func estimatedHeight(with descriptionText: String?) -> CGFloat {
//        guard let text = descriptionText else { return Constants.minimumHeight }
//        let rlPadding: CGFloat = 10
//        let width = UIScreen.main.bounds.width - (rlPadding * 2)
//        let maxHeight = UIScreen.main.bounds.height / 2
//        let font: UIFont = UIFont.systemFont(ofSize: 12, weight: .light)
//        let possibleRect = CGSize(width: width, height: maxHeight)
//        let boundingBox = text.boundingRect(with: possibleRect,
//                                            options: .usesLineFragmentOrigin,
//                                            attributes: [.font: font],
//                                            context: nil)
//        let otherHeight: CGFloat = 88
//        return otherHeight + boundingBox.height
//    }
    
}


extension BeerCell {
    struct Constants {
        static let imageViewCornerRadius: CGFloat = 6
        static let minimumHeight: CGFloat = 107
    }
}
