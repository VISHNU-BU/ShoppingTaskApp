//
//  CategoryListView.swift
//  ShoppingAppTest
//
//  Created by VISHNU MANGALASHERY on 03/08/24.
//

import SwiftUI
import CoreData

struct CategoryListView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)])
    private var categories: FetchedResults<Category>
    @EnvironmentObject var cartManager: CartManager
    
    @State private var showCategoryDropdown = false
    
    var body: some View {
        VStack {
            List {
                ForEach(categories) { category in
                    VStack(alignment: .leading) {
                        Text(category.name ?? "")
                            .font(.headline)
                            .underline()
                            .padding(.vertical)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(category.productsArray) { product in
                                    ProductCardView(product: product)
                                        .environmentObject(cartManager)
                                }
                            }
                            .padding()
                        }
                        .frame(height: 200)
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                showCategoryDropdown.toggle()
            }) {
                Text("Categories")
                    .frame(width: 120, height: 25)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showCategoryDropdown) {
                CategoryDropdownView()
            }
        }
    }
}

extension Category {
    var productsArray: [Product] {
        let set = products as? Set<Product> ?? []
        return set.sorted { $0.name ?? "" < $1.name ?? "" }
    }
}
