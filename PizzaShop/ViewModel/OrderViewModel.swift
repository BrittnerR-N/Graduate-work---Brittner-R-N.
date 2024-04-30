//
//  OrderViewModel.swift
//  PizzaShop
//
//  Created by Никита Тюрин on 23.04.24.
//

import Foundation

class OrderViewModel: ObservableObject {
    
    @Published var order: Order
    @Published var user = RNBUser(id: "", name: "", phone: 0, address: "")
    
    init(order: Order) {
        self.order = order
    }
    
    func getUserData() {
        DataBaseService.shared.getProfile(by: order.userID) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
