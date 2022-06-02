//
//  CardView.swift
//  Cooking With Martha
//
//  Created by Matthew Lock on 02/06/2022.
//

import UIKit

class CardView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    func initialSetup() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 8
        layer.shadowOpacity = 0.4
        layer.borderColor = UIColor(red: 175/255, green: 201/255, blue: 207/255, alpha: 1.0).cgColor
        layer.borderWidth = 1.5
        layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        layer.backgroundColor = UIColor(red: 253/255, green: 221/255, blue: 92/255, alpha: 1.0).cgColor
        layer.borderColor = UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0).cgColor
        layer.borderWidth = 1
    }

}
