//
//  ProductDetailViewModel.swift
//  PizzaShop
//
//  Created by Никита Тюрин on 15.04.24.
//

import Foundation

class ProductDetailViewModel: ObservableObject {
    
    @Published var product: Product
    @Published var sizes = ["Little", "Middle", "Big"]
    @Published var count = 0
    
            init(product: Product) {
                self.product = product
            }
    
    func getPrice(size: String) -> Int {
        switch size {
        case "Little": return product.price
        case "Middle": return Int(Double(product.price) * 1.25)
        case "Big": return Int(Double(product.price) * 1.5)
        default: return 0
        }
    }
}
