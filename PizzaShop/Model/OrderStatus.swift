//
//  OrderStatus.swift
//  PizzaShop
//
//  Created by Никита Тюрин on 23.04.24.
//

import Foundation

enum OrderStatus: String, CaseIterable {
    case new = "New"
    case cooking = "Cooking"
    case delivery = "Delivery"
    case completed = "Completed"
    case cancel = "Canceled"
}
