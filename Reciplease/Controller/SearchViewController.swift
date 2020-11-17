//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 17/11/2020.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: - PROPERTIES

    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientsTextView: UITextView!
    let alertManager = ServiceContainer.alertManager
    
    var ingredients: [String] = []
    
    // MARK: - FUNCTIONS

    /// Adds ingredient from ingredientTextField to ingredientsTextView
    @IBAction func addIngredient(_ sender: UIButton) {
        // Unwrap ingredientTextField text, else show an error alert
        guard let ingredient = ingredientTextField.text else {
            return showErrorEmptyOrNumberInIngredient()
        }
        // Check ingredient is not empty string, else show an error alert
        guard ingredient != "" else {
            return showErrorEmptyOrNumberInIngredient()
        }
        // Check ingredient do not contains any numerical digi, else show an error alert
        let numbersRange = ingredient.rangeOfCharacter(from: .decimalDigits)
        let hasNumbers = (numbersRange != nil)
        guard !hasNumbers else {
            return showErrorEmptyOrNumberInIngredient()
        }
        ingredients.append(ingredient)
        ingredientsTextView.text = ingredientsTextView.text + "- \(ingredient.capitalized)\n"
        ingredientTextField.text = nil
        
    }

    @IBAction func clearIngredients(_ sender: UIButton) {
        ingredients = []
        ingredientsTextView.text = ""
    }
    
    @IBAction func searchRecipes(_ sender: UIButton) {
    }
    
    private func showErrorEmptyOrNumberInIngredient() {
        ingredientTextField.text = nil
        return alertManager.showErrorAlert(
            title: "Insert an valid ingredient",
            message: "Please insert an ingredient name, without any numbers.",
            viewController: self
        )
    }
}
