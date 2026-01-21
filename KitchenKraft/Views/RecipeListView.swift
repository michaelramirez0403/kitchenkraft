//
//  RecipeListView.swift
//  KitchenKraft
//
//  Created by Macky Ramirez on 1/19/26.
//
import SwiftUI

struct RecipeListView: View {
    @ObservedObject var viewModel: RecipeListViewModel
    @EnvironmentObject var coordinator: AppCoordinator

    @State private var showFilters = false

    // Tuned for iOS “grid cards”
    private let horizontalPadding: CGFloat = 16
    private let gridSpacing: CGFloat = 12
    private let topContentPadding: CGFloat = 12

    private var hasActiveQueryOrFilters: Bool {
        !viewModel.searchText.isEmpty ||
        viewModel.vegetarianOnly ||
        viewModel.servings != nil ||
        !viewModel.includeIngredientsText.isEmpty ||
        !viewModel.excludeIngredientsText.isEmpty ||
        !viewModel.instructionSearchText.isEmpty
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            content
                .navigationTitle(Constant.RecipeList.title)
                .searchable(
                    text: $viewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: Constant.RecipeList.searchPlaceholder
                )
                .submitLabel(.done)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        if hasActiveQueryOrFilters {
                            Button(Constant.ButtonText.clear) { viewModel.resetFilters() }
                        }
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Button(Constant.ButtonText.filter) { showFilters = true }
                    }

                }
                .sheet(isPresented: $showFilters) {
                    RecipeFiltersView(viewModel: viewModel)
                }
                .task {
                    if viewModel.state == .idle {
                        await viewModel.loadInitial()
                    }
                }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .recipeDetail(let recipe):
                        RecipeDetailView(recipe: recipe)
                    }
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView(Constant.TitleMessage.loading)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .failed(let message):
            VStack(spacing: 12) {
                Text(Constant.TitleMessage.failedToLoad)
                    .font(.headline)

                Text(message)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                Button(Constant.ButtonText.retry) {
                    Task { await viewModel.loadInitial() }
                }
            }
            .padding(.horizontal, horizontalPadding)

        case .loaded:
            GeometryReader { geo in
                let availableWidth = geo.size.width - (horizontalPadding * 2)
                let cardWidth = floor((availableWidth - gridSpacing) / 2) // ✅ stable, no fractions

                ScrollView {
                    LazyVGrid(
                        columns: [
                            GridItem(.fixed(cardWidth), spacing: gridSpacing),
                            GridItem(.fixed(cardWidth), spacing: gridSpacing)
                        ],
                        spacing: gridSpacing
                    ) {
                        ForEach(viewModel.recipes) { recipe in
                            RecipeCardView(
                                recipe: recipe,
                                cardWidth: cardWidth
                            ) {
                                coordinator.push(.recipeDetail(recipe))
                            }
                        }
                    }
                    .padding(.horizontal, horizontalPadding)
                    .padding(.top, topContentPadding)
                    .padding(.bottom, 16)
                }
                .scrollDismissesKeyboard(.interactively)
                .overlay {
                    if viewModel.recipes.isEmpty {
                        ContentUnavailableView(
                            Constant.TitleMessage.noResults,
                            systemImage: Constant.SystemImg.magnifyingGlass,
                            description: Text(Constant.TitleMessage.filterPlaceholder)
                        )
                    }
                }
            }
        }
    }
}
