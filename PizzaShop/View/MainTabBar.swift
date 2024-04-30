//
//  MainTabBar.swift
//  PizzaShop
//
//  Created by Никита Тюрин on 29.03.24.
//

import SwiftUI

struct MainTabBar: View {
    
    var viewModel: MainTabBarViewModel
    
    var body: some View {
        
        TabView {
            
            NavigationView {
                CatalogView()
                        }
            .tabItem {
                VStack {
                    Image(systemName: "menucard")
                    Text("Каталог")
                }
            }
            
            CartView(viewModel: CartViewModel.shared)
                .tabItem {
                    VStack {
                        Image(systemName: "cart")
                        Text("Корзина")
                    }
                }
            
            ProfileView(viewModel: ProfileViewModel(profile: RNBUser(id: "",
                                                                     name: "Nameeeee",
                                                                     phone: 102938475,
                                                                     address: "ffffff")
            ))
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("Профиль")
                }
            }
        }
    }
}

