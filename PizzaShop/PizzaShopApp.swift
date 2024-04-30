//
//  PizzaShopApp.swift
//  PizzaShop
//
//  Created by Никита Тюрин on 27.03.24.
//

import SwiftUI
import Firebase
import FirebaseAuth

let screen = UIScreen.main.bounds

@main
struct PizzaShopApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            if let user = AuthService.shared.currentUser {
                if user.uid == "r4gz8Wf8RMQn8uv3FHVDutG9paI3" {
                   AdminOrdersView()
                } else {
                    
                    let viewModel = MainTabBarViewModel(user: user)
                    MainTabBar(viewModel: viewModel)
                }
            } else {                
                AuthView()
            }
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            
            FirebaseApp.configure()
            print("ok")
            return true
        }
    }
}

