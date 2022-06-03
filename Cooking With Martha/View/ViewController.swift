//
//  ViewController.swift
//  Cooking With Martha
//
//  Created by Matthew Lock on 07/05/2022.
//

import UIKit
import CardSlider
import Nuke

class ViewController: UIViewController, AddRecipeDelegate, DeleteRecipeDelegate, RevertRecipeList {
    
    var unfilteredRecipeList = [Item]()
    var recipeList = [Item]()
    var dataManager: DataManager?
    var categoryCollectionView: UICollectionView?
    var foodCategories = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        
        view.addSubview(header)
        view.addSubview(addButton)
        view.addSubview(deleteButton)
        view.addSubview(category)
        view.addSubview(recipeButton)
        recipeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
              recipeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              recipeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 230),
              recipeButton.heightAnchor.constraint(equalToConstant: 300),
              recipeButton.widthAnchor.constraint(equalToConstant: 300)
          ])
        loadRecipeBook()
        setupCollectionView()
        
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
    
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        categoryCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 360, height: 120), collectionViewLayout: layout)
        categoryCollectionView?.register(UINib(nibName: "CategoryCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        categoryCollectionView?.dataSource = self
        categoryCollectionView?.delegate = self
        categoryCollectionView?.center = CGPoint(x: 205, y: 400)
        categoryCollectionView?.backgroundColor = .clear
        categoryCollectionView?.showsVerticalScrollIndicator = false
        categoryCollectionView?.showsHorizontalScrollIndicator = false
        filterCategories()
        view.addSubview(categoryCollectionView!)
    }
    
    func filterCategories() {
        for recipe in recipeList {
            foodCategories.append(recipe.category)
        }
        foodCategories = foodCategories.uniqued()
    }

    let header: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 350, height: 60))
        label.center = CGPoint(x: 210, y: 120)
        label.textAlignment = .center
        label.font = UIFont(name: "CaveatBrush-Regular", size: 45)
        label.text = "Cooking with Martha"
        label.textColor = UIColor(red: 120/255, green: 159/255, blue: 204/255, alpha: 1.0)
        label.lineBreakMode = .byCharWrapping
        label.baselineAdjustment = .none
        return label
    }()
    
    let addButton: UIButton = {
       var button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 60))
        button.center = CGPoint(x: 110, y: 210)
        button.setTitle("Add", for: .normal)
        button.titleLabel!.font = UIFont(name: "CaveatBrush-Regular", size: 25)
        button.backgroundColor = UIColor(red: 253/255, green: 221/255, blue: 92/255, alpha: 1.0)
        button.setTitleColor(UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0).cgColor
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.addTarget(self, action: #selector(addRecipe), for: .touchUpInside)
        return button
    }()
    
    let deleteButton: UIButton = {
       var button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 60))
        button.center = CGPoint(x: 300, y: 210)
        button.setTitle("Delete", for: .normal)
        button.titleLabel!.font = UIFont(name: "CaveatBrush-Regular", size: 25)
        button.setTitleColor(UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0), for: .normal)
        button.backgroundColor = UIColor(red: 253/255, green: 221/255, blue: 92/255, alpha: 1.0)
        button.titleLabel?.textAlignment = .center
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0).cgColor
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.addTarget(self, action: #selector(deleteRecipe), for: .touchUpInside)
        return button
    }()
    
    let category: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 40))
        label.center = CGPoint(x: 210, y: 280)
        label.textAlignment = .center
        label.textColor = UIColor(red: 120/255, green: 159/255, blue: 204/255, alpha: 1.0)
        label.font = UIFont(name: "CaveatBrush-Regular", size: 32)
        label.text = "Category"
        label.lineBreakMode = .byCharWrapping
        label.baselineAdjustment = .none
        return label
    }()
    
    let recipeButton: UIButton = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        button.setBackgroundImage(UIImage(named: "cookbook"), for: .normal)
        
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor(red: 70/255, green: 74/255, blue: 74/255, alpha: 1.0).cgColor
        button.layer.shadowOpacity = 0.6
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10.0
        button.addTarget(self, action: #selector(showRecipeBook), for: .touchUpInside)
        return button
    }()
    
    @objc func showRecipeBook() {
        let vc = CardSliderViewController.with(dataSource: self)
        vc.title = "Recipe Book"
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func addRecipe() {
        let vc = AddViewController(recipes: recipeList)
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
        categoryCollectionView?.removeFromSuperview()
        foodCategories.removeAll()
        recipeList = recipe
        setupCollectionView()
    }
    
    func addNewRecipe(_ recipe: Item) {
        categoryCollectionView?.removeFromSuperview()
        recipeList.append(recipe)
        setupCollectionView()
    }

    func loadRecipeBook() {
        if recipeList.count == 0 {
            dataManager = DataManager()
            
            dataManager?.getRecipes{ [self] recipes in
                for recipe in recipes {
                    recipeList.append(Item(image: try! UIImage(withContentsOfUrl: URL(string:recipe.thumbNail)!)!, title: recipe.mealName, subtitle: recipe.type, category: recipe.category, description: recipe.instructions))
                }
            }
        }
    }
    
    func revert() {
        recipeList = unfilteredRecipeList
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        myCell.categoryLabel.text = foodCategories[indexPath.row]
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        unfilteredRecipeList = recipeList
        recipeList = recipeList.filter { $0.category == foodCategories[indexPath.row] }
        showRecipeBook()
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
