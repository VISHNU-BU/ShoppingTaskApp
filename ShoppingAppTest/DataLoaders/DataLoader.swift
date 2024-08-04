//
//  DataLoader.swift
//  ShoppingAppTest
//
//  Created by VISHNU MANGALASHERY on 03/08/24.
//

import Foundation

class DataLoader {
    
    func loadProductCategories(completion: @escaping ([ProductCategory]?) -> Void) {
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json") else {
            print("File not found")
            completion(nil)
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(ProductCategoriesResponse.self, from: data)
            completion(response.categories)
        } catch {
            print("Error loading or parsing JSON: \(error)")
            completion(nil)
        }
    }
}
