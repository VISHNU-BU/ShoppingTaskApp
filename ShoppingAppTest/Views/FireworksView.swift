//
//  ConfettiView.swift
//  ShoppingAppTest
//
//  Created by VISHNU MANGALASHERY on 04/08/24.
//

import SwiftUI

struct FireworksView: View {
    @State private var animate = false
    let colors: [Color] = [.orange, .green, .yellow, .blue, .red]

    var body: some View {
        ZStack {
            ForEach(0..<10) { index in
                Circle()
                    .fill(colors[index % colors.count])
                    .frame(width: 10, height: 10)
                    .offset(y: animate ? -200 : 0)
                    .rotationEffect(.degrees(Double(index) * 36))
                    .animation(Animation.easeOut(duration: 1).repeatForever(autoreverses: false), value: animate)
            }
            ForEach(0..<10) { index in
                Circle()
                    .fill(colors[(index + 5) % colors.count])
                    .frame(width: 10, height: 10)
                    .offset(y: animate ? -150 : 0)
                    .rotationEffect(.degrees(Double(index) * 36))
                    .animation(Animation.easeOut(duration: 1).repeatForever(autoreverses: false).delay(0.5), value: animate)
            }
        }
        .onAppear {
            animate.toggle()
        }
    }
}
