//
//  ProductCardView.swift
//  ShoppingAppTest
//
//  Created by VISHNU MANGALASHERY on 03/08/24.
//

import SwiftUI
import CoreData

struct ProductCardView: View {
    @ObservedObject var product: Product
    @EnvironmentObject var cartManager: CartManager
    @State private var showingFavoriteView = false
    @State private var showingCartView = false
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.icon ?? "")) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100)
            }
            
            Text(product.name ?? "Unknown Product")
                .font(.caption)
                .lineLimit(1)
                .truncationMode(.tail)
            
            Text("\(product.price, specifier: "%.2f")")
                .font(.caption)
                .foregroundColor(.gray)
            
            HStack {
                Button(action: {
                    if product.isFavorite {
                        cartManager.removeFromFavorites(product)
                    } else {
                        cartManager.addToFavorites(product)
                    }
                }) {
                    Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    if product.isInCart {
                        cartManager.removeFromCart(product)
                    } else {
                        cartManager.addToCart(product)
                    }
                }) {
                    Image(systemName: product.isInCart ? "cart.fill.badge.minus" : "cart.fill")
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        .frame(width: 150)
    }
}
