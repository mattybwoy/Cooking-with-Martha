//
//  CardViewController.swift
//  Cooking With Martha
//
//  Created by Matthew Lock on 07/05/2022.
//

import UIKit
import CardSlider

class CardSliderViewController: UIViewController, CardSliderDataSource {
    
    func item(for index: Int) -> CardSliderItem {
        let item = Recipe(image: UIImage(systemName: "cookbook")!, title: "First")
        return item
    }
    
    func numberOfItems() -> Int {
        return 1
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    


}
