//
//  BadgeViewModifier.swift
//  ShoppingAppTest
//
//  Created by VISHNU MANGALASHERY on 03/08/24.
//

import SwiftUI

struct BadgeViewModifier: ViewModifier {
    var count: Int

    func body(content: Content) -> some View {
        ZStack(alignment: .topTrailing) {
            content
            if count > 0 {
                Text("\(count)")
                    .font(.caption2)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.red)
                    .clipShape(Circle())
                    .offset(x: 10, y: -10)
            }
        }
    }
}

extension View {
    func badge(count: Int) -> some View {
        self.modifier(BadgeViewModifier(count: count))
    }
}
