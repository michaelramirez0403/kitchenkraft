//
//  RecipeFiltersView.swift
//  KitchenKraft
//
//  Created by Macky Ramirez on 1/19/26.
//
import SwiftUI

struct RecipeFiltersView: View {
    @ObservedObject var viewModel: RecipeListViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section(Constant.sectionTitle.quickFilter) {
                    Toggle(Constant.ButtonText.vegOnly, isOn: $viewModel.vegetarianOnly)
                        .onChange(of: viewModel.vegetarianOnly) { newValue in
                            print("Toggle changed:", newValue)
                        }
                    
                    Stepper(
                        value: Binding(
                            get: { viewModel.servings ?? 0 },
                            set: { viewModel.servings = ($0 == 0 ? nil : $0) }
                        ),
                        in: 0...20
                    ) {
                        Text("Servings: \(viewModel.servings.map(String.init) ?? "Any")")
                    }
                }
                
                Section(Constant.sectionTitle.ingredientFilter) {
                    TextField(Constant.TitleMessage.includeIngredients, text: $viewModel.includeIngredientsText)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    
                    TextField(Constant.TitleMessage.excludeIngredients, text: $viewModel.excludeIngredientsText)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                
                Section(Constant.sectionTitle.instructionSearch) {
                    TextField(Constant.TitleMessage.searchCookingInstruction, text: $viewModel.instructionSearchText)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                
                Section {
                    // With live filtering, this just closes the sheet.
                    Button(Constant.ButtonText.done) { dismiss() }
                    
                    Button(Constant.ButtonText.reset) {
                        viewModel.resetFilters()
                        dismiss()
                    }
                    .foregroundStyle(.red)
                }
            }
            .navigationTitle(Constant.navigationTitle.filters)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(Constant.ButtonText.close) { dismiss() }
                }
            }
        }
    }
}
