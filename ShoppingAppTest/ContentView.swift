//
//  ContentView.swift
//  ShoppingAppTest
//
//  Created by VISHNU MANGALASHERY on 03/08/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let coreDataHelper = CoreDataHelper()

    var body: some View {
        HomeScreen(context: coreDataHelper.persistentContainer.viewContext)
            .environment(\.managedObjectContext, coreDataHelper.persistentContainer.viewContext)
            .onAppear {
                DataLoader().loadProductCategories { categories in
                    if let categories = categories {
                        coreDataHelper.saveCategories(categories)
                    }
                }
            }
    }
}
