//
//  Recipe.swift
//  KitchenKraft
//
//  Created by Macky Ramirez on 1/19/26.
//

import Foundation

enum DietaryAttribute: String, Codable, CaseIterable, Hashable {
    case vegetarian
    case vegan
    case dairyFree = "dairy-free"
    case glutenFree = "gluten-free"
    case containsDairy = "contains-dairy"
    case containsPork = "contains-pork"
    case containsFish = "contains-fish"
    case containsShellfish = "contains-shellfish"

    var displayName: String {
        Constant.Dietary.displayName[self] ?? rawValue
    }
}

struct Recipe: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let description: String
    let numberOfServings: Int
    let ingredients: [String]
    let cookingInstructions: [String]
    let dietaryAttributes: [DietaryAttribute]
    let localImage: String?
}
