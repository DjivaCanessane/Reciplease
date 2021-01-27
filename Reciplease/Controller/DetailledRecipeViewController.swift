//
//  DetailledRecipeViewController.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 01/12/2020.
//

import UIKit
import SafariServices

class DetailledRecipeViewController: UIViewController {
    var displayableRecipe: DisplayableRecipe!
    let recipeDataManager = ServiceContainer.recipeDataManager
    let alertManager = ServiceContainer.alertManager

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeDuration: UILabel!
    @IBOutlet weak var recipeYield: UILabel!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeIngredients: UITextView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRecipeDataToUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setFavoriteBarButtonItemImage()
    }

    @IBAction func getDirectionsForRecipe(_ sender: UIRoundedButton) {
        guard let url = URL(string: displayableRecipe.recipeURL) else {
            return ServiceContainer.alertManager.showErrorAlert(
                title: "Error",
                message: "Error while unwrapping recipe URL.",
                viewController: self
            )
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }

    @IBAction func addOrRemoveRecipeFromFavorite(_ sender: UIBarButtonItem) {
        return sender.image == UIImage(systemName: "star.fill") ?
            removeRecipeFromFavorite() : addRecipeToFavorite()
    }

    private func fetchRecipeDataToUI() {
        recipeImage.image = UIImage(data: displayableRecipe.imageData)
        recipeDuration.text = displayableRecipe.duration == 0 ? "N/A" : "\(displayableRecipe.duration)"
        recipeYield.text = displayableRecipe.yield == 0 ? "N/A" : "\(displayableRecipe.yield)"
        recipeName.text = displayableRecipe.dishName
        displayableRecipe.ingredients.forEach { (ingredient) in
            recipeIngredients.text += "\n - \(ingredient)"
        }
    }

    ///Sets the favoriteBarButtonItem's image according to the presence of recipeWithImage in Core Data
    private func setFavoriteBarButtonItemImage() {
        do {
            favoriteButton.image =
                try recipeDataManager.isFavorite(recipeUrl: displayableRecipe.recipeURL)
            ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        } catch {
            alertManager.showErrorAlert(
                title: "Internal memory error",
                message: "Can not retrieve data from Core Data.",
                viewController: self
            )

        }
    }

    ///Saves the RecipeWithImage in Core Data and sets the favoriteBarButtonItem's image to filled star
    private func addRecipeToFavorite() {
        do {
            try recipeDataManager.save(displayableRecipe)
        } catch {
            alertManager.showErrorAlert(
                title: "Internal memory error",
                message: "Can not save data in Core Data.",
                viewController: self
            )
        }
        favoriteButton.image = UIImage(systemName: "star.fill")
    }

    ///Removes the Recipe from Core Data and sets the favoriteButton's image to unfilled star
    private func removeRecipeFromFavorite() {
        do {
            try recipeDataManager.deleteRecipeData(withUrl: displayableRecipe.recipeURL)
        } catch {
            alertManager.showErrorAlert(
                title: "Internal memory error",
                message: "Can not remove data from Core Data.",
                viewController: self
            )
        }
        favoriteButton.image = UIImage(systemName: "star")
    }

}
