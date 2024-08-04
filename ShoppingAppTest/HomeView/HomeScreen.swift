//
//  HomeScreen.swift
//  ShoppingAppTest
//
//  Created by VISHNU MANGALASHERY on 04/08/24.
//

import SwiftUI
import CoreData

struct HomeScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var cartManager: CartManager
    @State private var showSidebar = false


    init(context: NSManagedObjectContext) {
        _cartManager = StateObject(wrappedValue: CartManager(context: context))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        showSidebar.toggle()
                            }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title2)
                            .padding()
                            }
                    
                    Text("My Store")
                        .font(.largeTitle)
                        .padding(.leading)
                    
                    Spacer()
                    
                    NavigationLink(destination: CartView().environmentObject(cartManager)) {
                        Image(systemName: "cart")
                            .badge(count: cartManager.cartItems.count)
                            .padding(.trailing)
                    }
                    
                    NavigationLink(destination: FavoritesView().environmentObject(cartManager)) {
                        Image(systemName: "heart")
                            .badge(count: cartManager.favoriteItems.count)
                            .padding(.trailing)
                    }
                }
                .padding()
                .padding(.top)
                
            .background(
                LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .edgesIgnoringSafeArea(.top)
            )
                CategoryListView()
                    .environmentObject(cartManager)
                    .onAppear {
                        cartManager.fetchCartItems()
                        cartManager.fetchFavoriteItems()
                    }
            }
            .navigationBarHidden(true)
        }
    }
}
