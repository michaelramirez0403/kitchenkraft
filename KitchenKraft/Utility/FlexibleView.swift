//
//  FlexibleView.swift
//  KitchenKraft
//
//  Created by Macky Ramirez on 1/20/26.
//
//
// Minimal flexible wrapping layout helper
import SwiftUI
struct FlexibleView<Data: Collection,
                        Content: View>: View where Data.Element: Hashable {

    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content

    @State private var availableWidth: CGFloat = 0

    private var rows: [[Data.Element]] {
        guard availableWidth > 0 else { return [Array(data)] }

        var rows: [[Data.Element]] = [[]]
        var currentWidth: CGFloat = 0

        for element in data {
            let elementWidth = elementSize(element).width + spacing

            if currentWidth + elementWidth > availableWidth,
               !rows[rows.count - 1].isEmpty {
                rows.append([element])
                currentWidth = elementWidth
            } else {
                rows[rows.count - 1].append(element)
                currentWidth += elementWidth
            }
        }

        return rows
    }

    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {

            GeometryReader { geo in
                Color.clear
                    .onAppear { availableWidth = geo.size.width }
                    .onChange(of: geo.size.width) { _, newValue in
                        availableWidth = newValue
                    }
            }
            .frame(height: 0)

            ForEach(rows.indices, id: \.self) { rowIndex in
                HStack(spacing: spacing) {
                    ForEach(rows[rowIndex], id: \.self) { element in
                        content(element)
                    }
                }
            }
        }
    }

    private func elementSize(_ element: Data.Element) -> CGSize {
        let text = String(describing: element) as NSString
        let font = UIFont.preferredFont(forTextStyle: .caption1)
        let size = text.size(withAttributes: [.font: font])

        return CGSize(
            width: size.width + 20,
            height: size.height + 12
        )
    }
}
