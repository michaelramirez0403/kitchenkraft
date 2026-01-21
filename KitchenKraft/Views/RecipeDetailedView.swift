//
//  RecipeDetailedView.swift
//  KitchenKraft
//
//  Created by Macky Ramirez on 1/19/26.
//
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    private let horizontalPadding: CGFloat = 20
    private let headerHeight: CGFloat = 220
    private let headerCornerRadius: CGFloat = 18

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                headerImage

                titleBlock

                sectionTitle(Constant.RecipeDetail.dietary)
                FlowTags(tags: recipe.dietaryAttributes.map { $0.displayName })

                sectionTitle(Constant.RecipeDetail.ingredients)
                ingredientsList

                sectionTitle(Constant.RecipeDetail.cookingInstructions)
                instructionsList
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.top, 12)
            .padding(.bottom, 32)
        }
        .background(Color(.systemBackground))
        .navigationTitle(Constant.RecipeList.recipe)
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Header

    @ViewBuilder
    private var headerImage: some View {
        if let localImage = recipe.localImage,
           let uiImage = UIImage(named: localImage) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(height: headerHeight)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: headerCornerRadius,
                        style: .continuous
                    )
                )
        } else {
            RoundedRectangle(cornerRadius: headerCornerRadius, style: .continuous)
                .fill(.secondary.opacity(0.15))
                .frame(height: headerHeight)
                .overlay(
                    Image(systemName: Constant.SystemImg.forkKnifeCircle)
                        .font(.system(size: 44))
                        .foregroundStyle(.secondary)
                )
        }
    }

    // MARK: - Title Block

    private var titleBlock: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text(recipe.title)
                .font(.title2)
                .bold()

            Text(recipe.description)
                .foregroundStyle(.secondary)

            Label(
                "\(Constant.RecipeDetail.serves) \(recipe.numberOfServings)",
                systemImage: Constant.SystemImg.person
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
    }

    // MARK: - Ingredients

    private var ingredientsList: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(recipe.ingredients, id: \.self) { item in
                Text("• \(item)")
            }
        }
    }

    // MARK: - Instructions

    private var instructionsList: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(
                Array(recipe.cookingInstructions.enumerated()),
                id: \.offset
            ) { index, step in
                Text("\(index + 1). \(step)")
            }
        }
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.headline)
            .padding(.top, 4)
    }
}

#Preview("Recipe Detail") {
    RecipeDetailView(
        recipe: Recipe(
            id: "recipe_001",
            title: "Asian Flank Steak",
            description: "Tender flank steak marinated in savory Asian flavors and grilled to perfection.",
            numberOfServings: 2,
            ingredients: [
                "500 g flank steak",
                "3 tbsp soy sauce",
                "2 tbsp oyster sauce",
                "1 tbsp brown sugar",
                "2 cloves garlic",
                "1 tsp grated ginger",
                "1 tbsp sesame oil"
              ],
            cookingInstructions: [
                "Mix soy sauce, oyster sauce, sugar, garlic, ginger, and sesame oil.",
                "Marinate steak for 30 minutes.",
                "Heat grill pan and cook steak 4–5 minutes per side.",
                "Rest meat before slicing and serving."
              ],
            dietaryAttributes: [.dairyFree],
            localImage: "asian_flank_steak"
        )
    )
}
