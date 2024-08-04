//
//  CartItemView.swift
//  ShoppingAppTest
//
//  Created by VISHNU MANGALASHERY on 04/08/24.
//

import SwiftUI

struct CartItemView: View {
    @ObservedObject var product: Product
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: URL(string: product.icon ?? "")) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                        .frame(width: 60, height: 60)
                }
                
                VStack(alignment: .leading) {
                    Text(product.name ?? "Unknown Product")
                        .font(.headline)
                    
                    Text("\(product.price, specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("Quantity: \(product.quantity)")
                        .font(.subheadline)
                }
                
                Spacer()
                
                VStack {
                    Button(action: {
                        cartManager.removeFromCart(product)
                    }) {
                        Image(systemName: "minus.circle")
                    }
                    .padding(.bottom, 8)
                    
                    Button(action: {
                        cartManager.addToCart(product)
                    }) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(radius: 5)
        )
    }
}
