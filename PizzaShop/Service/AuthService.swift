//
//  AuthService.swift
//  PizzaShop
//
//  Created by Никита Тюрин on 16.04.24.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    static let shared = AuthService()
    
    private init() { }
    
    let auth = Auth.auth()
    
    var currentUser: User? {
        return auth.currentUser
    }
    
    func signOut() {
        try! auth.signOut()
    }
    
    func signUp(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> () ) {
        
        auth.createUser(withEmail: email, password: password) { result, error in
            if let result = result {
                let rnbUser = RNBUser(id: result.user.uid,
                                      name: "",
                                      phone: 0,
                                      address: "")
                
                DataBaseService.shared.setProfile(user: rnbUser) { resultDB in
                    switch resultDB {
                    case .success(_):
                        completion(.success(result.user))

                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> () )  {
        
        auth.signIn(withEmail: email, password: password) { result, error in
            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
}
