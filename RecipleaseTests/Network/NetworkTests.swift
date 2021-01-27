//
//  NetworkTests.swift
//  RecipleaseTests
//
//  Created by Djiveradjane Canessane on 15/01/2021.
//

import XCTest
@testable import Reciplease

class NetworkTests: XCTestCase {
    var recipeQueryNetworkManager: RecipesQueryNetworkManager!
    var networkRequest: NetworkRequest!
    var ingredients = ["Rice", "Oil"]

    func setUpReal() {
        networkRequest = AlamofireNetworkRequest()
        recipeQueryNetworkManager = RecipesQueryNetworkManager(networkRequest: networkRequest)
    }

    override func tearDown() {
        super.tearDown()
        recipeQueryNetworkManager = nil
        networkRequest = nil
    }

    // MARK: - Test Errors thrown in Failures
    func testGetRecipes_WhenGivingNoIngredient_ShouldReturnFailureWithNoIngredientNetworkError() {
        setUpReal()
        recipeQueryNetworkManager.getRecipes(for: []) { (result) in
            switch result {
            case .success: XCTFail("test failed")
            case .failure(let error): XCTAssertEqual(error, NetworkError.noIngredients)
            }
        }
    }

    func testGetRecipes_WhenGivingNonDecodableRecipe_ShouldReturnFailureWithCanNotDecodeNetworkError() {
        let data = Data(base64Encoded: "test")
        networkRequest = FakeRecipeNetworkRequest(data: data, error: nil)
        recipeQueryNetworkManager = RecipesQueryNetworkManager(networkRequest: networkRequest)
        recipeQueryNetworkManager.getRecipes(for: ingredients) { (result) in
            switch result {
            case .success: XCTFail("test failed")
            case .failure(let error): XCTAssertEqual(error, NetworkError.decodingError)
            }
        }
    }

    func testGetRecipes_WhenResponseHasError_ShouldReturnFailureWithHasErrorNetworkError() {
        let data = Data(base64Encoded: "test")
        let error = NetworkError.hasError
        networkRequest = FakeRecipeNetworkRequest(data: data, error: error)
        recipeQueryNetworkManager = RecipesQueryNetworkManager(networkRequest: networkRequest)
        recipeQueryNetworkManager.getRecipes(for: ingredients) { (result) in
            switch result {
            case .success: XCTFail("test failed")
            case .failure(let error): XCTAssertEqual(error, NetworkError.hasError)
            }
        }
    }

    func testGetRecipes_WhenResponseIsEmpty_ShouldReturnFailureWithEmptyDataNetworkError() {
        networkRequest = FakeRecipeNetworkRequest(data: nil, error: nil)
        recipeQueryNetworkManager = RecipesQueryNetworkManager(networkRequest: networkRequest)
        recipeQueryNetworkManager.getRecipes(for: ingredients) { (result) in
            switch result {
            case .success: XCTFail("test failed")
            case .failure(let error): XCTAssertEqual(error, NetworkError.emptyData)
            }
        }
    }

    func testGetImage_WhenDoNotReturnImageData_ShouldReturnFailureWithDefaultImageData() {
        let testImageData: Data = UIImage(named: "foodImage")!.pngData()!
        networkRequest = FakeImageNetworkRequestWillFail()
        recipeQueryNetworkManager = RecipesQueryNetworkManager(networkRequest: networkRequest)
        recipeQueryNetworkManager.getRecipes(for: ingredients) { (result) in
            switch result {
            case .success(let displayableRecipes):
                let displayabaleRecipe = displayableRecipes.first!
                self.tesDiplayableRecipe(displayabaleRecipe, testImageData: testImageData)
            case .failure: XCTFail("test failed")
            }
        }
    }

    // MARK: - Test Success
    func testGetRecipes_WhenRecipeResponseAndImageResponseAreCorrect_ShouldReturnSuccessWithDisplayableRecipe() {
        let testImageData: Data = "testImageData".data(using: .utf8)!
        networkRequest = FakeImageNetworkRequestWillSucceed()
        recipeQueryNetworkManager = RecipesQueryNetworkManager(networkRequest: networkRequest)
        recipeQueryNetworkManager.getRecipes(for: ingredients) { (result) in
            switch result {
            case .success(let displayableRecipes):
                let displayabaleRecipe = displayableRecipes.first!
                self.tesDiplayableRecipe(displayabaleRecipe, testImageData: testImageData)
            case .failure: XCTFail("test failed")
            }
        }
    }

    private func tesDiplayableRecipe(_ displayabaleRecipe: DisplayableRecipe, testImageData: Data) {
        let ingredientLines = [
            "1 1/2 cups semolina flour",
            "1 1/2 cups white whole wheat flour (or all-purpose flour)",
            "1 teaspoon fine-grain sea salt",
            "1 cup warm water",
            "1/3 cup extra virgin olive oil"
        ]
        XCTAssertEqual(displayabaleRecipe.imageData, testImageData)
        XCTAssertEqual(
            displayabaleRecipe.imageURL,
            "https://www.edamam.com/web-img/d35/d35614d9aac3d80c44f4583e6f2c59cb")
        XCTAssertEqual(
            displayabaleRecipe.recipeURL,
            "http://www.101cookbooks.com/archives/olive-oil-crackers-recipe.html")
        XCTAssertEqual(displayabaleRecipe.dishName, "Olive Oil Cracker recipes")
        XCTAssertEqual(displayabaleRecipe.yield, 4.0)
        XCTAssertEqual(displayabaleRecipe.duration, 60.0)
        XCTAssertEqual(displayabaleRecipe.ingredients, ingredientLines)
    }
}
