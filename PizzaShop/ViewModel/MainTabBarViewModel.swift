//
//  MainTabBarViewModel.swift
//  PizzaShop
//
//  Created by Никита Тюрин on 17.04.24.
//

import Foundation
import FirebaseAuth

class MainTabBarViewModel: ObservableObject {
    
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}
