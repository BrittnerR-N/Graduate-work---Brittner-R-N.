//
//  RNBUser.swift
//  PizzaShop
//
//  Created by Никита Тюрин on 17.04.24.
//

import Foundation

struct RNBUser: Identifiable {
    
    var id: String = UUID().uuidString
    var name: String
    var phone: Int
    var address: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["name"] = self.name
        repres["phone"] = self.phone
        repres["address"] = self.address
        return repres
    }
}
