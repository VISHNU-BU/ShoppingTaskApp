//
//  CartManager.swift
//  ShoppingAppTest
//
//  Created by VISHNU MANGALASHERY on 03/08/24.
//

import CoreData

class CartManager: ObservableObject {
    @Published var cartItems: [Product] = []
    @Published var favoriteItems: [Product] = []
    private let viewContext: NSManagedObjectContext
    
    var subtotal: Double {
        cartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
        }
    
    var discount: Double {
            return subtotal * 0.3
        }
    
    var total: Double {
            subtotal - discount
        }

    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchCartItems()
        fetchFavoriteItems()
    }
    
    func addToCart(_ product: Product) {
            if let existingProduct = cartItems.first(where: { $0.id == product.id }) {
                existingProduct.quantity += 1
            } else {
                product.isInCart = true
                product.quantity = 1
                cartItems.append(product)
            }
        objectWillChange.send()
            saveContext()
        }
    
    func removeFromCart(_ product: Product) {
            if let existingProduct = cartItems.first(where: { $0.id == product.id }) {
                existingProduct.quantity -= 1
                if existingProduct.quantity == 0 {
                    product.isInCart = false
                    cartItems.removeAll { $0.id == product.id }
                }
            }
        objectWillChange.send()
            saveContext()
        }

    func addToFavorites(_ product: Product) {
        product.isFavorite = true
        favoriteItems.append(product)
        saveContext()
    }

    func removeFromFavorites(_ product: Product) {
        product.isFavorite = false
        favoriteItems.removeAll { $0.id == product.id }
        saveContext()
    }

    internal func fetchCartItems() {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isInCart == true")

        do {
            cartItems = try viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch cart items: \(error)")
        }
    }

    internal func fetchFavoriteItems() {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isFavorite == true")

        do {
            favoriteItems = try viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch favorite items: \(error)")
        }
    }
    
    func checkout() {
            cartItems.forEach { product in
                product.isInCart = false
            }
            cartItems.removeAll()
            saveContext()
        }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
