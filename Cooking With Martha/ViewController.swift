//
//  ViewController.swift
//  Cooking With Martha
//
//  Created by Matthew Lock on 07/05/2022.
//

import UIKit
import CardSlider

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(header)
        
    }

    let header: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 350, height: 50))
        label.center = CGPoint(x: 210, y: 120)
        label.textAlignment = .center
        label.font = UIFont(name: "MonteCarlo-Regular", size: 45)
        label.text = "Cooking with Martha"
        return label
    }()
    
}

