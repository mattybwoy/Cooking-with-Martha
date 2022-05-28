//
//  DataManager.swift
//  Cooking With Martha
//
//  Created by Matthew Lock on 11/05/2022.
//

import Foundation

class DataManager: DeleteRecipeDelegate {
    
    var recipes = [Recipe]()
    
    func getRecipes(completion: @escaping ([Recipe]) -> Void) {
    
        guard let fileURL = Bundle.main.url(forResource: "Recipes", withExtension: "json") else {
            return
        }
        do {
            let data = try Data(contentsOf: fileURL)
            self.recipes = try JSONDecoder().decode([Recipe].self, from: data)
            completion(self.recipes)
        } catch {
            print(error)
        }
    }
    
    func removeRecipe(_ recipe: String) {
        print(recipe)
    }
    
    
    
}
