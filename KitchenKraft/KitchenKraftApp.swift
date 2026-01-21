//
//  KitchenKraftApp.swift
//  KitchenKraft
//
//  Created by Macky Ramirez on 1/18/26.
//
import SwiftUI

@main
struct KitchenKraftApp: App {
    @StateObject private var coordinator = AppCoordinator()
    @StateObject private var viewModel: RecipeListViewModel

    init() {
        let api = MockRecipeAPI(file: .recipes)
        let repository = RecipeRepository(api: api)
        _viewModel = StateObject(wrappedValue: RecipeListViewModel(repository: repository))
    }

    var body: some Scene {
        WindowGroup {
            RecipeListView(viewModel: viewModel)
                .environmentObject(coordinator)
        }
    }
}
