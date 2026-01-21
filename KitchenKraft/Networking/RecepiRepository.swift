//
//  RecepiRepository.swift
//  KitchenKraft
//
//  Created by Macky Ramirez on 1/19/26.
//
import Foundation

protocol RecipeRepositoryProtocol {
    func getAll() async throws -> [Recipe]
    func search(_ request: RecipeSearchRequest) async throws -> [Recipe]
}

final class RecipeRepository: RecipeRepositoryProtocol {
    private let api: RecipeAPIProtocol

    init(api: RecipeAPIProtocol) {
        self.api = api
    }

    func getAll() async throws -> [Recipe] {
        try await api.fetchAllRecipes()
    }

    func search(_ request: RecipeSearchRequest) async throws -> [Recipe] {
        try await api.searchRecipes(request)
    }
}
