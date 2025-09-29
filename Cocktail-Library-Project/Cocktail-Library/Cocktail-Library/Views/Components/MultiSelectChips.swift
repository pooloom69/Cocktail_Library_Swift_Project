//
//  MultiSelectChips.swift
//  Cocktail-Library
//
//  Created by Sola Lhim on 9/10/25.
//

import SwiftUI

struct MultiSelectChips: View {
    let options: [String]
    @Binding var selection: Set<String>
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    if selection.contains(option) {
                        selection.remove(option)
                    } else {
                        selection.insert(option)
                    }
                }) {
                    Text(option)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(selection.contains(option) ? Color.orange : Color.gray.opacity(0.2))
                        .foregroundColor(selection.contains(option) ? .white : .black)
                        .cornerRadius(12)
                }
            }
        }
    }
}


struct FlowLayout<Content: View>: View {
    let items: [String]
    let spacing: CGFloat
    let content: (String) -> Content
    
    init(items: [String], spacing: CGFloat = 8, @ViewBuilder content: @escaping (String) -> Content) {
        self.items = items
        self.spacing = spacing
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }
    
    private func generateContent(in geometry: GeometryProxy) -> some View {
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        return ZStack(alignment: .topLeading) {
            ForEach(items, id: \.self) { item in
                content(item)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading) { d in
                        if (x + d.width > geometry.size.width) {
                            // wrap to next line
                            x = 0
                            y -= d.height + spacing
                        }
                        let result = x
                        x -= d.width + spacing
                        return result
                    }
                    .alignmentGuide(.top) { _ in
                        let result = y
                        if item == items.last {
                            x = 0 // reset after last
                            y = 0
                        }
                        return result
                    }
            }
        }
    }
}
