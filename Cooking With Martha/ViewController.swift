//
//  ViewController.swift
//  Cooking With Martha
//
//  Created by Matthew Lock on 07/05/2022.
//

import UIKit
import CardSlider
import Nuke

class ViewController: UIViewController {
    
    var data = [Item]()
    var dataManager: DataManager?
    
    let imageURL = URL(string: "https://www.themealdb.com/images/media/meals/58oia61564916529.jpg")!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(header)
        view.addSubview(addButton)
        view.addSubview(deleteButton)
        view.addSubview(category)
        view.addSubview(recipeButton)
        loadRecipeBook()
        
        data.append(Item(image: try! UIImage(withContentsOfUrl: imageURL)!, rating: 1, title: "Corba", subtitle: "Turkish", description: "Pick through your lentils for any foreign debris, rinse them 2 or 3 times, drain, and set aside.  Fair warning, this will probably turn your lentils into a solid block that you’ll have to break up later\r\nIn a large pot over medium-high heat, sauté the olive oil and the onion with a pinch of salt for about 3 minutes, then add the carrots and cook for another 3 minutes.\r\nAdd the tomato paste and stir it around for around 1 minute. Now add the cumin, paprika, mint, thyme, black pepper, and red pepper as quickly as you can and stir for 10 seconds to bloom the spices. Congratulate yourself on how amazing your house now smells.\r\nImmediately add the lentils, water, broth, and salt. Bring the soup to a (gentle) boil.\r\nAfter it has come to a boil, reduce heat to medium-low, cover the pot halfway, and cook for 15-20 minutes or until the lentils have fallen apart and the carrots are completely cooked.\r\nAfter the soup has cooked and the lentils are tender, blend the soup either in a blender or simply use a hand blender to reach the consistency you desire. Taste for seasoning and add more salt if necessary.\r\nServe with crushed-up crackers, torn up bread, or something else to add some extra thickness.  You could also use a traditional thickener (like cornstarch or flour), but I prefer to add crackers for some texture and saltiness.  Makes great leftovers, stays good in the fridge for about a week."))
    }

    let header: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 350, height: 60))
        label.center = CGPoint(x: 210, y: 120)
        label.textAlignment = .center
        label.font = UIFont(name: "MonteCarlo-Regular", size: 45)
        label.text = "Cooking with Martha"
        label.lineBreakMode = .byCharWrapping
        label.baselineAdjustment = .none
        return label
    }()
    
    let addButton: UIButton = {
       var button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        button.center = CGPoint(x: 100, y: 210)
        button.setTitle("Add", for: .normal)
        button.titleLabel!.font = UIFont(name: "MonteCarlo-Regular", size: 25)
        button.setTitleColor(UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0).cgColor
        button.layer.cornerRadius = 8
        return button
    }()
    
    let deleteButton: UIButton = {
       var button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        button.center = CGPoint(x: 300, y: 210)
        button.setTitle("Delete", for: .normal)
        button.titleLabel!.font = UIFont(name: "MonteCarlo-Regular", size: 25)
        button.setTitleColor(UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0).cgColor
        button.layer.cornerRadius = 8
        return button
    }()
    
    let category: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 40))
        label.center = CGPoint(x: 210, y: 280)
        label.textAlignment = .center
        label.font = UIFont(name: "MonteCarlo-Regular", size: 32)
        label.text = "Category"
        label.lineBreakMode = .byCharWrapping
        label.baselineAdjustment = .none
        return label
    }()
    
    let recipeButton: UIButton = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        button.center = CGPoint(x: 210, y: 650)
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

    func loadRecipeBook() {
        dataManager = DataManager()

        dataManager?.getRecipes{ recipes in
            print(recipes)
            print("hll")
        }
    }
    
}

extension ViewController: CardSliderDataSource {
    
    func item(for index: Int) -> CardSliderItem {
    
        return data[index]
    }
    
    func numberOfItems() -> Int {
        return data.count
    }
    
    
}

extension UIImage {

    convenience init?(withContentsOfUrl url: URL) throws {
        let imageData = try Data(contentsOf: url)
    
        self.init(data: imageData)
    }

}
