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
    
}


extension BeerCell {
    struct Constants {
        static let imageViewCornerRadius: CGFloat = 6
        static let minimumHeight: CGFloat = 107
    }
}
