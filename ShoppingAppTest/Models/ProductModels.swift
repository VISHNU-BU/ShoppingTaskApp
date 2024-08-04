//
//  ProductModels.swift
//  ShoppingAppTest
//
//  Created by VISHNU MANGALASHERY on 03/08/24.
//

import Foundation

struct ProductCategoriesResponse: Codable {
    let status: Bool
    let message: String
    let error: String?
    let categories: [ProductCategory]
}

struct ProductCategory: Codable, Identifiable {
    let id: Int
    let name: String
    let items: [ProductItem]
}

struct ProductItem: Codable, Identifiable {
    let id: Int
    let name: String
    let icon: String
    let price: Double
}
