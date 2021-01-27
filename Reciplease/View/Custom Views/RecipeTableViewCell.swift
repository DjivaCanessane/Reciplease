//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 26/11/2020.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with recipe: DisplayableRecipe) {
        let durationStr = recipe.duration == 0 ? "N/A" : "\(recipe.duration)"
        let yieldStr = recipe.yield == 0 ? "N/A" : "\(recipe.yield)"
        recipeImage.image = UIImage(data: recipe.imageData)
        recipeLabel.text = recipe.dishName

        var ingredients: String {
            var ingredients = ""
            for ingredient in recipe.ingredients {
                ingredients += "\(ingredient), "
            }
            return ingredients
        }
        ingredientsLabel.text = ingredients
        durationLabel.text = durationStr
        yieldLabel.text = yieldStr
    }

}
