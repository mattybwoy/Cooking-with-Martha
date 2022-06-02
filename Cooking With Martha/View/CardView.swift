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
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 8
        layer.shadowOpacity = 0.4
        layer.borderColor = UIColor.systemGreen.cgColor
        layer.borderWidth = 1.5
    }

}
