//
//  RecipeSearchEngine.swift
//  KitchenKraft
//
//  Created by Macky Ramirez on 1/19/26.
//
import Foundation

enum RecipeSearchEngine {
    static func filter(_ recipes: [Recipe], with request: RecipeSearchRequest) -> [Recipe] {
        let q = request.query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let instrQ = request.instructionQuery.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        let include = request.includeIngredients
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
            .filter { !$0.isEmpty }

        let exclude = request.excludeIngredients
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
            .filter { !$0.isEmpty }

        return recipes
            .filter { recipe in
                if request.vegetarianOnly {
                    guard recipe.dietaryAttributes.contains(.vegetarian) || recipe.dietaryAttributes.contains(.vegan) else { return false }
                }
                if let servings = request.servings, recipe.numberOfServings != servings {
                    return false
                }

                if !q.isEmpty {
                    let haystack = [
                        recipe.title.lowercased(),
                        recipe.description.lowercased(),
                        recipe.ingredients.joined(separator: " ").lowercased()
                    ].joined(separator: " | ")
                    if !haystack.contains(q) { return false }
                }

                if !instrQ.isEmpty {
                    let instructionText = recipe.cookingInstructions.joined(separator: " ").lowercased()
                    if !instructionText.contains(instrQ) { return false }
                }

                if !include.isEmpty {
                    let ing = recipe.ingredients.map { $0.lowercased() }
                    let ok = include.allSatisfy { token in
                        ing.contains(where: { $0.contains(token) })
                    }
                    if !ok { return false }
                }

                if !exclude.isEmpty {
                    let ing = recipe.ingredients.map { $0.lowercased() }
                    let bad = exclude.contains { token in
                        ing.contains(where: { $0.contains(token) })
                    }
                    if bad { return false }
                }

                return true
            }
            .sorted { $0.title < $1.title }
    }
}
