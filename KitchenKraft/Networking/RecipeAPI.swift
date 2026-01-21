//
//  RecipeAPI.swift
//  KitchenKraft
//
//  Created by Macky Ramirez on 1/19/26.
//
import Foundation

struct RecipeSearchRequest: Hashable {
    var query: String = ""
    var vegetarianOnly: Bool = false
    var servings: Int? = nil

    /// If non-empty, recipe must contain ALL of these (case-insensitive contains)
    var includeIngredients: [String] = []

    /// If non-empty, recipe must contain NONE of these
    var excludeIngredients: [String] = []

    /// Search inside cooking instructions (case-insensitive)
    var instructionQuery: String = ""
}

protocol RecipeAPIProtocol {
    func fetchAllRecipes() async throws -> [Recipe]
    func searchRecipes(_ request: RecipeSearchRequest) async throws -> [Recipe]
}

/// Mock API that loads from local JSON but behaves like a network layer.
final class MockRecipeAPI: RecipeAPIProtocol {
    private let fileName: String

    init(file: Constant.MockData = .recipes) {
        self.fileName = file.rawValue
    }

    func fetchAllRecipes() async throws -> [Recipe] {
        // Simulate network latency if desired:
        // try await Task.sleep(nanoseconds: 150_000_000)
        return try LocalJSONLoader.load(fileName, as: [Recipe].self)
    }

    func searchRecipes(_ request: RecipeSearchRequest) async throws -> [Recipe] {
        let all = try await fetchAllRecipes()
        return RecipeSearchEngine.filter(all, with: request)
    }
}

