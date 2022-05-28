//
//  DeleteViewController.swift
//  Cooking With Martha
//
//  Created by Matthew Lock on 28/05/2022.
//

import UIKit

protocol DeleteRecipeDelegate {
    func removeRecipe(_ recipe: String)
}

class DeleteViewController: UIViewController {

    var deleteDelegate: DeleteRecipeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        view.backgroundColor = .lightGray
        view.addSubview(header)
        view.addSubview(deleteTextField)
        deleteTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
              deleteTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              deleteTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
              deleteTextField.heightAnchor.constraint(equalToConstant: 40),
              deleteTextField.widthAnchor.constraint(equalToConstant: 280)
          ])
        view.addSubview(backButton)
        view.addSubview(deleteRecipeButton)
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
        label.text = "Delete a recipe"
        label.lineBreakMode = .byCharWrapping
        label.baselineAdjustment = .none
        return label
    }()
    
    let deleteTextField: UITextField = {
        var delete = UITextField()
        delete.font = UIFont(name: "CaveatBrush-Regular", size: 25)
        delete.placeholder = "Type in name of recipe"
        delete.borderStyle = UITextField.BorderStyle.roundedRect
        delete.layer.borderColor = UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0).cgColor
        delete.layer.borderWidth = 1.5
        delete.layer.cornerRadius = 8
        return delete
    }()
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    let deleteRecipeButton: UIButton = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        button.tintColor = .black
        button.center = CGPoint(x: 210, y: 530)
        button.setTitle("Delete", for: .normal)
        button.titleLabel!.font = UIFont(name: "CaveatBrush-Regular", size: 25)
        button.setTitleColor(UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0).cgColor
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(deleteRecipeTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func deleteRecipeTapped() {
        guard let deletedRecipe = deleteTextField.text, !deletedRecipe.isEmpty else {
            let alert = UIAlertController(title: "Alert", message: "Empty field, please try again", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: nil))
            alert.view.accessibilityIdentifier = "Empty field"
            self.present(alert, animated: true, completion: nil)
            return
        }
        deleteDelegate?.removeRecipe(deletedRecipe)
        self.dismiss(animated: true, completion: nil)
    }

}
