//
//  CategoryDropdownView.swift
//  ShoppingAppTest
//
//  Created by VISHNU MANGALASHERY on 04/08/24.
//

import SwiftUI
import CoreData

struct CategoryDropdownView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)])
    private var categories: FetchedResults<Category>
    
    @Environment(\.dismiss) private var dismis
    
    var body: some View {
        NavigationView {
            List {
                ForEach(categories) { category in
                    Text(category.name ?? "")
                }
            }
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismis()
                    }
                }
            }
        }
    }
}
