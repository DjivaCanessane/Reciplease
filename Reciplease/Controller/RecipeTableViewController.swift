//
//  RecipeTableViewController.swift
//  Reciplease
//
//  Created by Djiveradjane Canessane on 26/11/2020.
//

import UIKit

class RecipeTableViewController: UITableViewController {
    var displayableRecipes: [DisplayableRecipe] = []
    var isComingFromSeachVC: Bool = false
    let recipeDataManager = ServiceContainer.recipeDataManager
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        loadData()
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    private func loadData() {
        if  !isComingFromSeachVC {
            let recipesData: [RecipeData] = recipeDataManager.all
            displayableRecipes = []
            for recipeData in recipesData {
                let displayableRecipe = DisplayableRecipe(
                    imageData: recipeData.imageData ?? UIImage(named: "foodImage")!.pngData()!,
                    imageURL: recipeData.imageURL ?? "",
                    recipeURL: recipeData.recipeURL ?? "",
                    dishName: recipeData.name ?? "",
                    yield: Double(recipeData.yield),
                    duration: Int(recipeData.duration),
                    ingredients: recipeData.ingredients ?? []
                )
                displayableRecipes.append(displayableRecipe)
            }
        }
        self.tableView.reloadData()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(160)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayableRecipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recipeCell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        let displayableRecipe: DisplayableRecipe = displayableRecipes[indexPath.row]
        recipeCell.configure(with: displayableRecipe)
        return recipeCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "detailledRecipe", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? RecipeTableViewCell {
            let i = self.tableView.indexPath(for: cell)!.row
            if segue.identifier == "detailledRecipe" {
                let vc = segue.destination as! DetailledRecipeViewController
                vc.displayableRecipe = displayableRecipes[i]
            }
        }
    }
    
    
}
