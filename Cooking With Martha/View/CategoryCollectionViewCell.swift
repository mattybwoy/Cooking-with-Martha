//
//  CategoryCollectionViewCell.swift
//  Cooking With Martha
//
//  Created by Matthew Lock on 01/06/2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    
    static let identifier = "CategoryCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupFont()
    }
    
    func setupFont() {
        categoryLabel.font = UIFont(name: "CaveatBrush-Regular", size: 18)
        categoryLabel.adjustsFontSizeToFitWidth = true
        categoryLabel.textColor = UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0)
    }
    
    
}
