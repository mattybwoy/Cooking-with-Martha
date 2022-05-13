//
//  Recipe.swift
//  Cooking With Martha
//
//  Created by Matthew Lock on 11/05/2022.
//

import Foundation

struct Recipe: Decodable {
    var idMeal: String
    var mealName: String
    var category: String
    var type: String
    var instructions: String
    var thumbNail: String
    var youtubeLink: String?
    var source: String?
}
