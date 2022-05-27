//
//  AddViewController.swift
//  Cooking With Martha
//
//  Created by Matthew Lock on 13/05/2022.
//

import UIKit
import KMPlaceholderTextView
import DropDown

protocol AddRecipeDelegate {
    func addNewRecipe(_ recipe: Item)
}

class AddViewController: UIViewController {
    
    var recipe: Item?
    var recipeDelegate: AddRecipeDelegate?
    var recipeImage: UIImage?
    
    enum fieldType {
        case title
        case type
        case description
        case category
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(header)
        view.addSubview(recipeTitle)
        view.addSubview(recipeType)
        //view.addSubview(recipeCategory)
        view.addSubview(recipeDescription)
        view.addSubview(backButton)
        view.addSubview(addRecipeButton)
        view.addSubview(addPhotoButton)
        view.backgroundColor = .lightGray
        setupCategorySelector()
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
        title.center = CGPoint(x: 210, y: 220)
        title.placeholder = "Title"
        title.font = UIFont(name: "CaveatBrush-Regular", size: 25)
        title.borderStyle = UITextField.BorderStyle.roundedRect
        title.layer.borderColor = UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0).cgColor
        title.layer.borderWidth = 1.5
        title.layer.cornerRadius = 8
        return title
    }()
    
    let recipeType: UITextField = {
        var type = UITextField(frame: CGRect(x: 0, y: 0, width: 280, height: 40))
        type.center = CGPoint(x: 210, y: 280)
        type.placeholder = "Type"
        type.font = UIFont(name: "CaveatBrush-Regular", size: 25)
        type.borderStyle = UITextField.BorderStyle.roundedRect
        type.layer.borderColor = UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0).cgColor
        type.layer.borderWidth = 1.5
        type.layer.cornerRadius = 8
        return type
    }()
    
    let recipeCategory: UITextField = {
        var type = UITextField(frame: CGRect(x: 0, y: 0, width: 280, height: 40))
        type.center = CGPoint(x: 210, y: 340)
        type.placeholder = "Category"
        type.font = UIFont(name: "CaveatBrush-Regular", size: 25)
        type.borderStyle = UITextField.BorderStyle.roundedRect
        return type
    }()
    
    let categorySelector = UIButton(frame: CGRect(x: 0, y: 0, width: 280, height: 40))
    
    let categoryDropdown: DropDown = {
        let categories = DropDown()
        categories.dataSource = [
        "Vegetarian",
        "Dessert",
        "Side"
        ]
        categories.textColor = .darkGray
        categories.textFont = UIFont(name: "CaveatBrush-Regular", size: 25)!
        categories.selectedTextColor = .black
        DropDown.appearance().selectionBackgroundColor = .darkGray
        DropDown.appearance().cornerRadius = 8
        categories.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            cell.optionLabel.textAlignment = .center
        }
        return categories
    }()
    
    func setupCategorySelector() {
        categorySelector.center = CGPoint(x: 210, y: 340)
        categorySelector.setTitle("Category", for: .normal)
        categorySelector.titleLabel?.font = UIFont(name: "CaveatBrush-Regular", size: 25)
        categorySelector.layer.borderColor = UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0).cgColor
        categorySelector.layer.cornerRadius = 8
        categorySelector.backgroundColor = .white
        categorySelector.setTitleColor(.darkGray, for: .normal)
        categorySelector.layer.borderWidth = 1.5
        categoryDropdown.anchorView = categorySelector
        categoryDropdown.bottomOffset = CGPoint(x: 0, y: categorySelector.frame.size.height)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCategorySelector))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        categorySelector.addGestureRecognizer(gesture)
        view.addSubview(categorySelector)
    }
    
    @objc func didTapCategorySelector() {
        categoryDropdown.show()
        categoryDropdown.selectionAction = { index, category in
            print("index \(index) at \(category)")
            self.categorySelector.setTitle(category, for: .normal)
        }
    }
    
    let recipeDescription: KMPlaceholderTextView = {
        var description = KMPlaceholderTextView(frame: CGRect(x: 0, y: 0, width: 280, height: 220))
        description.center = CGPoint(x: 210, y: 500)
        description.font = UIFont(name: "CaveatBrush-Regular", size: 25)
        description.layer.cornerRadius = 8
        description.isEditable = true
        description.placeholder = "Description"
        description.dataDetectorTypes = UIDataDetectorTypes.link
        description.layer.borderColor = UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0).cgColor
        description.layer.borderWidth = 1.5
        return description
    }()
    
    let addRecipeButton: UIButton = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        button.tintColor = .black
        button.center = CGPoint(x: 200, y: 800)
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
    
    let addPhotoButton: UIButton = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale:.medium)
        let mediumBoldIcon = UIImage(systemName: "square.and.arrow.up", withConfiguration: config)
        let uploadIcon = mediumBoldIcon!.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
        button.setImage(uploadIcon, for: .normal)
        button.tintColor = .black
        button.center = CGPoint(x: 200, y: 650)
        button.setTitle("  Upload Image", for: .normal)
        button.titleLabel!.font = UIFont(name: "CaveatBrush-Regular", size: 25)
        button.setTitleColor(UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0).cgColor
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(uploadImage), for: .touchUpInside)
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
        guard let categorySelect = categoryDropdown.selectedItem else {
            throwAlert(field: fieldType.category)
            return
        }
        guard let descriptionText = recipeDescription.text, !descriptionText.isEmpty else {
            throwAlert(field: fieldType.description)
            return
        }
            recipe = Item(image: (recipeImage ?? UIImage(systemName: "questionmark"))!, rating: 1, title: titleText, subtitle: typeText, category: categorySelect, description: descriptionText)
            confirm()
    }
    
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func uploadImage() {
        let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true)
    }
    
    func imageConfirmation() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale:.large)
        let largeBoldIcon = UIImage(systemName: "checkmark.circle", withConfiguration: largeConfig)
        let greenCheck = largeBoldIcon!.withTintColor(.green, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: greenCheck)
        imageView.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.center = CGPoint(x: 200, y: 720)
        view.addSubview(imageView)
    }
    
    func confirm() {
        if recipe?.image == UIImage(systemName: "questionmark") {
            throwMissingImageAlert()
        } else {
            confirmationMessageShown()
        }
    }
    
    func confirmationMessageShown() {
        recipeDelegate?.addNewRecipe(recipe!)
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
    
    func throwMissingImageAlert() {
        let alert = UIAlertController(title: "Warning", message: "Missing Image, are you sure you want to proceed?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (_) in self.confirmationMessageShown() } ))
        alert.view.accessibilityIdentifier = "Missing Photo alert"
        self.present(alert, animated: true, completion: nil)
    }

    
}

extension AddViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        recipeImage = image
        dismiss(animated: true)
        imageConfirmation()
    }
    
    
}
