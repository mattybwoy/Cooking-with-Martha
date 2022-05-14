//
//  AddViewController.swift
//  Cooking With Martha
//
//  Created by Matthew Lock on 13/05/2022.
//

import UIKit
import KMPlaceholderTextView

class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(header)
        view.addSubview(recipeTitle)
        view.addSubview(recipeType)
        view.addSubview(recipeDescription)
        view.addSubview(backButton)
        view.backgroundColor = .lightGray
    }
    
    let backButton: UIButton = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.center = CGPoint(x: 40, y: 80)
        button.setImage(UIImage(systemName: "arrowshape.turn.up.backward.fill"), for: .normal)
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
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }

}
