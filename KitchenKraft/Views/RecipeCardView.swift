//
//  RecipeCardView.swift
//  KitchenKraft
//
//  Created by Macky Ramirez on 1/19/26.
//
import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe
    let cardWidth: CGFloat
    let onTap: () -> Void

    private let cornerRadius: CGFloat = 18
    private let imageCornerRadius: CGFloat = 14

    // ✅ Fixed sizing = consistent grid
    private var imageHeight: CGFloat { floor(cardWidth * 0.66) } // ~ 3:2 feel
    private let cardHeight: CGFloat = 260 // ✅ locks row height across varying titles/flags

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 10) {
                thumbnail
                    .frame(width: cardWidth, height: imageHeight)
                    .clipShape(RoundedRectangle(cornerRadius: imageCornerRadius, style: .continuous))
                    .clipped()

                titleAndDescription
                    .padding(.horizontal, 2)

                Spacer(minLength: 0)

                footerRow
            }
            .padding(12)
            .frame(width: cardWidth, height: cardHeight, alignment: .top)
            .background(cardBackground)
            .overlay(cardBorder)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .contentShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
        .buttonStyle(.plain)
    }

    private var titleAndDescription: some View {
        VStack(alignment: .leading, spacing: 6) {

            Text(recipe.title)
                .font(.headline)
                .foregroundStyle(.primary)
                .lineLimit(2)
                .truncationMode(.tail)
                .multilineTextAlignment(.leading)

            Text(recipe.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
                .truncationMode(.tail)
                .multilineTextAlignment(.leading)
        }
        // Keeps grid perfectly aligned
        //.frame(height: 56, alignment: .top)
        //.frame(maxWidth: .infinity, alignment: .leading)
        .frame(minHeight: 56, alignment: .top)   //
    }

    private var footerRow: some View {
        HStack(spacing: 8) {
            Label("\(recipe.numberOfServings)",
                  systemImage: Constant.SystemImg.person)
                .font(.caption)
                .foregroundStyle(.secondary)

            Spacer(minLength: 0)

            if recipe.dietaryAttributes.contains(.vegetarian) || recipe.dietaryAttributes.contains(.vegan) {
                Text(Constant.RecipeList.veg)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.thinMaterial)
                    .clipShape(Capsule())
            } else {
                // ✅ keeps footer height identical even when badge is absent
                Color.clear.frame(width: 44, height: 24)
            }
        }
    }

    @ViewBuilder
    private var thumbnail: some View {
        if let localImage = recipe.localImage,
           let uiImage = UIImage(named: localImage) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill() // ✅ crop to fill fixed frame
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: imageCornerRadius, style: .continuous)
                    .fill(.secondary.opacity(0.12))
                Image(systemName: Constant.SystemImg.forkKife)
                    .font(.system(size: 28, weight: .regular))
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(Color(.secondarySystemBackground))
    }

    private var cardBorder: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .stroke(Color(.separator).opacity(0.25), lineWidth: 1)
    }
}
