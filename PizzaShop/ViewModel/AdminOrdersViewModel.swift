//
//  AdminOrdersViewModel.swift
//  PizzaShop
//
//  Created by Никита Тюрин on 23.04.24.
//

import Foundation

class AdminOrdersViewModel: ObservableObject {
    
    @Published var orders = [Order]()
    
    var currentOrder = Order(userID: "", date: Date(), status: "New")
    
    func getOrders() {
        DataBaseService.shared.gerOrders(by: nil) { result in
            switch result {
            case .success(let orders):
                self.orders = orders
                for (index, order) in self.orders.enumerated() {
                    DataBaseService.shared.getPositions(by: order.id) { result in
                        switch result {
                        case .success(let positions):
                            self.orders[index].positions = positions
                            print(self.orders[index].cost)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
