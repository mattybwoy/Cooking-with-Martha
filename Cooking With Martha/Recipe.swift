//
//  Recipe.swift
//  Cooking With Martha
//
//  Created by Matthew Lock on 11/05/2022.
//

import Foundation

struct Recipe: Decodable {
    var image: String
    var rating: Int?
    var title: String
    var subtitle: String?
    var description: String?
}