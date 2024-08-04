//
//  ToolbarItemView.swift
//  ShoppingAppTest
//
//  Created by VISHNU MANGALASHERY on 03/08/24.
//

import SwiftUI


struct HalfSheet<Content: View>: View {
    @Binding var isPresented: Bool
    let content: () -> Content

    var body: some View {
        ZStack {
            if isPresented {
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        self.content()
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                            .frame(width: geometry.size.width, height: geometry.size.height / 2)
                            .transition(.move(edge: .bottom))
                            .animation(.easeInOut, value: isPresented)
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    .onTapGesture {
                        isPresented = false
                    }
                }
            }
        }
    }
}
