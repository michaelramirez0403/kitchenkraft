//
//  Constant.swift
//  KitchenKraft
//
//  Created by Macky Ramirez on 1/19/26.
//
import Foundation
struct Constant {
    enum MockData: String {
        case recipes = "Mockrecipes"
    }
    enum Dietary {
        /// Centralized UI strings
        static let displayName: [DietaryAttribute: String] = [
            .vegetarian: "Vegetarian",
            .vegan: "Vegan",
            .dairyFree: "Dairy-Free",
            .glutenFree: "Gluten-Free",
            .containsDairy: "Contains Dairy",
            .containsPork: "Contains Pork",
            .containsFish: "Contains Fish",
            .containsShellfish: "Contains Shellfish"
        ]
    }
    enum RecipeList {
        static let title = "Recipes"
        static let recipe = "Recipe"
        static let veg = "Veg"
        static let searchPlaceholder = "Search recipes, ingredients, instructions..."
    }
    enum ButtonText {
        static let clear = "Clear"
        static let filter = "Filter"
        static let done = "Done"
        static let retry = "Retry"
        static let close = "Close"
        static let vegOnly = "Vegetarian only"
        static let reset = "Reset"
    }
    enum TitleMessage {
        static let noResults = "No Results"
        static let failedToLoad = "Failed to load."
        static let loading = "Loading recipes..."
        static let filterPlaceholder = "Try adjusting your search or filters."
        static let includeIngredients = "Include ingredients (comma-separated)"
        static let excludeIngredients = "Exclude ingredients (comma-separated)"
        static let searchCookingInstruction = "Search cooking instructions..."
    }
    enum SystemImg {
        static let magnifyingGlass = "magnifyingglass"
        static let person = "person.2"
        static let forkKife = "fork.knife"
        static let forkKnifeCircle = "fork.knife.circle"
    }
    enum RecipeDetail {
        static let dietary = "Dietary"
        static let ingredients = "Ingredients"
        static let cookingInstructions = "Cooking Instructions"
        static let serves = "Serves"
    }
    enum sectionTitle {
        static let quickFilter = "Quick Filters"
        static let ingredientFilter = "Ingredient Filters"
        static let instructionSearch = "Instruction Search"
    }
    enum navigationTitle {
        static let filters = "Filters"
    }
}
