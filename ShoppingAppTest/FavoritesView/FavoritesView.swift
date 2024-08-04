//
//  FavoritesView.swift
//  ShoppingAppTest
//
//  Created by VISHNU MANGALASHERY on 03/08/24.
//

import SwiftUI
import CoreData

struct FavoritesView: View {
    @EnvironmentObject var cartManager: CartManager
    private let columns = [GridItem(.adaptive(minimum: 150))] 
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(cartManager.favoriteItems) { product in
                    ProductCardView(product: product)
                        .environmentObject(cartManager)
                }
            }
            .padding()
        }
        .navigationTitle("Favorites")
    }
}
