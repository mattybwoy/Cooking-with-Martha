//
//  AddViewController.swift
//  Cooking With Martha
//
//  Created by Matthew Lock on 13/05/2022.
//

import UIKit

class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(header)
        view.backgroundColor = .lightGray
    }
    
    let header: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 350, height: 60))
        label.center = CGPoint(x: 210, y: 120)
        label.textAlignment = .center
        label.font = UIFont(name: "CaveatBrush-Regular", size: 45)
        label.text = "Add a recipe"
        label.lineBreakMode = .byCharWrapping
        label.baselineAdjustment = .none
        return label
    }()
    

}
