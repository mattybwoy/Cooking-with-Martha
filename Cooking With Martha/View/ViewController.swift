//
//  ViewController.swift
//  Cooking With Martha
//
//  Created by Matthew Lock on 07/05/2022.
//

import UIKit
import CardSlider
import Nuke

class ViewController: UIViewController, AddRecipeDelegate, DeleteRecipeDelegate {
    
    var pickerData = ["All"]
    var recipeList = [Item]()
    var dataManager: DataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        
        view.addSubview(header)
        view.addSubview(addButton)
        view.addSubview(deleteButton)
        view.addSubview(category)
        view.addSubview(recipeButton)
        view.addSubview(categoryPicker)
        recipeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
              recipeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              recipeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
              recipeButton.heightAnchor.constraint(equalToConstant: 300),
              recipeButton.widthAnchor.constraint(equalToConstant: 300)
          ])
        loadRecipeBook()
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
    }
    
    func assignbackground(){
        let background = UIImage(named: "cookingBackground")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.alpha = 0.1
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }

    let header: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 350, height: 60))
        label.center = CGPoint(x: 210, y: 120)
        label.textAlignment = .center
        label.font = UIFont(name: "CaveatBrush-Regular", size: 45)
        label.text = "Cooking with Martha"
        label.lineBreakMode = .byCharWrapping
        label.baselineAdjustment = .none
        return label
    }()
    
    let addButton: UIButton = {
       var button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        button.center = CGPoint(x: 100, y: 210)
        button.setTitle("Add", for: .normal)
        button.titleLabel!.font = UIFont(name: "CaveatBrush-Regular", size: 25)
        button.setTitleColor(UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0).cgColor
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(addRecipe), for: .touchUpInside)
        return button
    }()
    
    let deleteButton: UIButton = {
       var button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        button.center = CGPoint(x: 300, y: 210)
        button.setTitle("Delete", for: .normal)
        button.titleLabel!.font = UIFont(name: "CaveatBrush-Regular", size: 25)
        button.setTitleColor(UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0).cgColor
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(deleteRecipe), for: .touchUpInside)
        return button
    }()
    
    let category: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 40))
        label.center = CGPoint(x: 210, y: 280)
        label.textAlignment = .center
        label.font = UIFont(name: "CaveatBrush-Regular", size: 32)
        label.text = "Category"
        label.lineBreakMode = .byCharWrapping
        label.baselineAdjustment = .none
        return label
    }()
    
    let categoryPicker: UIPickerView = {
        var picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 220, height: 120))
        picker.center = CGPoint(x: 210, y: 380)
        picker.layer.borderColor = UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0).cgColor
        picker.layer.borderWidth = 1.5
        picker.layer.cornerRadius = 8
        return picker
    }()
    
    let recipeButton: UIButton = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        button.setBackgroundImage(UIImage(named: "cookbook"), for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(showRecipeBook), for: .touchUpInside)
        return button
    }()
    
    @objc func showRecipeBook() {
        let vc = CardSliderViewController.with(dataSource: self)
        vc.title = "Recipe Book"
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func addRecipe() {
        let vc = AddViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.recipeDelegate = self
        present(vc, animated: true)
    }
    
    @objc func deleteRecipe() {
        let vc = DeleteViewController(recipes: recipeList)
        vc.deleteDelegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func removeRecipe(_ recipe: [Item]) {
        recipeList = recipe
    }
    
    func addNewRecipe(_ recipe: Item) {
        recipeList.append(recipe)
    }

    func loadRecipeBook() {
        if recipeList.count == 0 {
            dataManager = DataManager()
            
            dataManager?.getRecipes{ [self] recipes in
                for recipe in recipes {
                    recipeList.append(Item(image: try! UIImage(withContentsOfUrl: URL(string:recipe.thumbNail)!)!, rating: 1, title: recipe.mealName, subtitle: recipe.type, category: recipe.category, description: recipe.instructions))
                }
            }
        }
    }
    
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
}

extension ViewController: CardSliderDataSource {
    
    func item(for index: Int) -> CardSliderItem {
        return recipeList[index]
    }
    
    func numberOfItems() -> Int {
        return recipeList.count
    }
    
    
}

extension UIImage {

    convenience init?(withContentsOfUrl url: URL) throws {
        let imageData = try Data(contentsOf: url)
    
        self.init(data: imageData)
    }

}
