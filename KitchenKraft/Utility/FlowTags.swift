//
//  FlowTags.swift
//  KitchenKraft
//
//  Created by Macky Ramirez on 1/20/26.
//

import SwiftUI

/// Simple wrap layout for dietary tags
struct FlowTags: View {
    let tags: [String]

    var body: some View {
        FlexibleView(data: tags, spacing: 8, alignment: .leading) { tag in
            Text(tag)
                .font(.caption)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(.thinMaterial)
                .clipShape(Capsule())
        }
    }
}
