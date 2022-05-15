//
//  AddViewController.swift
//  Cooking With Martha
//
//  Created by Matthew Lock on 13/05/2022.
//

import UIKit
import KMPlaceholderTextView

protocol AddRecipeDelegate {
    func addNewRecipe(_ recipe: Item)
}

class AddViewController: UIViewController {
    
    var recipe: Item?
    var recipeDelegate: AddRecipeDelegate?
    
    enum fieldType {
        case title
        case type
        case description
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(header)
        view.addSubview(recipeTitle)
        view.addSubview(recipeType)
        view.addSubview(recipeDescription)
        view.addSubview(backButton)
        view.addSubview(addRecipeButton)
        view.backgroundColor = .lightGray
    }
    
    let backButton: UIButton = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        button.center = CGPoint(x: 40, y: 80)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .bold, scale:.large)
        let largeBoldIcon = UIImage(systemName: "arrow.backward", withConfiguration: largeConfig)
        button.setImage(largeBoldIcon, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
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
    
    let recipeTitle: UITextField = {
        var title = UITextField(frame: CGRect(x: 0, y: 0, width: 280, height: 40))
        title.center = CGPoint(x: 210, y: 250)
        title.placeholder = "Title"
        title.font = UIFont(name: "CaveatBrush-Regular", size: 25)
        title.borderStyle = UITextField.BorderStyle.roundedRect
        return title
    }()
    
    let recipeType: UITextField = {
        var type = UITextField(frame: CGRect(x: 0, y: 0, width: 280, height: 40))
        type.center = CGPoint(x: 210, y: 320)
        type.placeholder = "Type"
        type.font = UIFont(name: "CaveatBrush-Regular", size: 25)
        type.borderStyle = UITextField.BorderStyle.roundedRect
        return type
    }()
    
    let recipeDescription: KMPlaceholderTextView = {
        var description = KMPlaceholderTextView(frame: CGRect(x: 0, y: 0, width: 280, height: 220))
        description.center = CGPoint(x: 210, y: 500)
        description.font = UIFont(name: "CaveatBrush-Regular", size: 25)
        description.layer.cornerRadius = 8
        description.isEditable = true
        description.placeholder = "Description"
        description.dataDetectorTypes = UIDataDetectorTypes.link
        return description
    }()
    
    let addRecipeButton: UIButton = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        button.tintColor = .black
        button.center = CGPoint(x: 300, y: 700)
        button.setTitle("Add", for: .normal)
        button.titleLabel!.font = UIFont(name: "CaveatBrush-Regular", size: 25)
        button.setTitleColor(UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0).cgColor
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(submitRecipeTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func submitRecipeTapped() {
        guard let titleText = recipeTitle.text, !titleText.isEmpty else {
            throwAlert(field: fieldType.title)
            return
        }
        guard let typeText = recipeType.text, !typeText.isEmpty else {
            throwAlert(field: fieldType.type)
            return
        }
        guard let descriptionText = recipeDescription.text, !descriptionText.isEmpty else {
            throwAlert(field: fieldType.description)
            return
        }
        recipe = Item(image: UIImage(systemName: "peacesign")!, rating: 1, title: titleText, subtitle: typeText, description: descriptionText)
        recipeDelegate?.addNewRecipe(recipe!)
        confirmation()
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func confirmation() {
        let alert = UIAlertController(title: "Thank You!", message: "Your new recipe has now been added to the cookbook", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.view.accessibilityIdentifier = "recipe added confirmation"
        self.present(alert, animated: true, completion: nil)
    }
    
    func throwAlert(field: fieldType) {
        let alert = UIAlertController(title: "Alert", message: "Empty \(field), please try again", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: nil))
        alert.view.accessibilityIdentifier = "Empty \(field) field"
        self.present(alert, animated: true, completion: nil)
    }

}
