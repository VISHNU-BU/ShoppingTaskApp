//
//  CoreDataHelper.swift
//  ShoppingAppTest
//
//  Created by VISHNU MANGALASHERY on 03/08/24.
//

import CoreData

class CoreDataHelper {
    let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "ShoppingApp")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }

    func saveCategories(_ categories: [ProductCategory]) {
        let context = persistentContainer.viewContext
        let existingCategoryIDs = Set(fetchExistingCategoryIDs(context: context))

        for categoryData in categories {
            if existingCategoryIDs.contains(Int32(categoryData.id)) {
                continue
            }

            let category = Category(context: context)
            category.id = Int32(categoryData.id)
            category.name = categoryData.name

            for itemData in categoryData.items {
                let product = Product(context: context)
                product.id = Int32(itemData.id)
                product.name = itemData.name
                product.icon = itemData.icon
                product.price = itemData.price
                product.category = category
            }
        }

        do {
            try context.save()
        } catch {
            print("Failed to save categories: \(error)")
        }
    }

    private func fetchExistingCategoryIDs(context: NSManagedObjectContext) -> [Int32] {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.resultType = .managedObjectResultType
        fetchRequest.propertiesToFetch = ["id"]

        do {
            let results = try context.fetch(fetchRequest)
            let ids = results.compactMap { $0.id }
            return ids
        } catch {
            print("Failed to fetch existing categories: \(error)")
            return []
        }
    }
}
