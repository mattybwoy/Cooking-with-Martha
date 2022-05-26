//
//  Recipe.swift
//  Cooking With Martha
//
//  Created by Matthew Lock on 08/05/2022.
//

import Foundation
import CardSlider

struct Item: CardSliderItem {
    var image: UIImage
    var rating: Int?
    var title: String
    var subtitle: String?
    var category: String
    var description: String?
}
