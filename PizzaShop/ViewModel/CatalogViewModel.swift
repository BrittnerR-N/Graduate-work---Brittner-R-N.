//
//  CatalogViewModel.swift
//  PizzaShop
//
//  Created by Никита Тюрин on 30.03.24.
//

import Foundation

class CatalogViewModel: ObservableObject {
    
    static let shared = CatalogViewModel()
    
    var popularProducts = [
        Product(
        id: "1",
        title: "Margarita",
        imageUrl: "Not Found",
        price: 600,
        descript: "XXXXxxXX"
        ),
        
        Product(
        id: "2",
        title: "pipironi",
        imageUrl: "Not Found",
        price: 450,
        descript: "XXXXxxXX"
        ),
        
        Product(
        id: "3",
        title: "gavaii",
        imageUrl: "Not Found",
        price: 400,
        descript: "XXXXxxXX"
        ),
        
        Product(
        id: "4",
        title: "macintosh",
        imageUrl: "Not Found",
        price: 550,
        descript: "XXXXxxXX"
        ),
        
        Product(
        id: "5",
        title: "pizza 5",
        imageUrl: "Not Found",
        price: 650,
        descript: "XXXXxxXX"
        )
    ]
    
    @Published var pizzaProducts = [
        Product(
        id: "1",
        title: "Margarita",
        imageUrl: "Not Found",
        price: 600,
        descript: "XXXXxxXX"
        ),
        
        Product(
        id: "2",
        title: "pipironi",
        imageUrl: "Not Found",
        price: 450,
        descript: "XXXXxxXX"
        ),
        
        Product(
        id: "3",
        title: "gavaii",
        imageUrl: "Not Found",
        price: 400,
        descript: "XXXXxxXX"
        ),
        
        Product(
        id: "4",
        title: "macintosh",
        imageUrl: "Not Found",
        price: 550,
        descript: "XXXXxxXX"
        ),
        
        Product(
        id: "5",
        title: "pizza 5",
        imageUrl: "Not Found",
        price: 650,
        descript: "XXXXxxXX"
        )
    ]
    
    func getProducts() {
        DataBaseService.shared.getProducts { result in
            switch result {
            case .success(let products):
                self.pizzaProducts = products
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
