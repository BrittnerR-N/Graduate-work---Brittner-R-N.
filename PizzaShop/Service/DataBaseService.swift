//
//  DataBaseService.swift
//  PizzaShop
//
//  Created by Никита Тюрин on 17.04.24.
//

import Foundation
import FirebaseFirestore

class DataBaseService {
    
    static let shared = DataBaseService()
    
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference { return db.collection("users") }
    private var ordersRef: CollectionReference { return db.collection("orders") }
    private var productsRef: CollectionReference { return db.collection("products") }
    
    private init() { }
    
    func getPositions(by orderID: String, completion: @escaping (Result<[Position], Error>) -> ()) {
        
        let positionRef = ordersRef.document(orderID).collection("positions")
        
        positionRef.getDocuments { qSnap, error in
            if let querySnapshot = qSnap {
                var positions = [Position]()
                for doc in querySnapshot.documents {
                    if let position = Position(doc: doc) {
                        positions.append(position)
                    }
                }
                completion(.success(positions))
            } else if let error = error {
                completion(.failure(error))
            }
            
        }
    }
    
    func gerOrders(by userID: String?,
                   completion: @escaping (Result<[Order], Error>) -> ()) {
        
        self.ordersRef.getDocuments { qSnap, error in
            
            if let qSnap = qSnap {
                var orders = [Order]()
                for doc in qSnap.documents {
                    if let userID = userID {
                        if let order = Order(doc: doc), order.userID == userID {
                            orders.append(order)
                        }
                    } else { //Branch of Admin
                        if let order = Order(doc: doc) {
                            orders.append(order)
                        }
                    }
                }
                completion(.success(orders))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func setOrder(order: Order,
                  completion: @escaping (Result<Order, Error>) -> ()) {
        ordersRef.document(order.id).setData(order.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.setPosititons(to: order.id,
                              positions: order.positions) { result in
                    switch result {
                    case .success(let posititons):
                        print(posititons.count)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                completion(.success(order))
            }
        }
    }
    
    func setPosititons(to orderId: String,
                      positions: [Position],
                      completion: @escaping (Result<[Position], Error>) -> ()) {
        
        let positionRef = ordersRef.document(orderId).collection("positions")
        
        for position in positions {
            positionRef.document(position.id).setData(position.representation)
        }
        
        completion(.success(positions))
    }
    
    func setProfile(user: RNBUser, completion: @escaping (Result<RNBUser, Error>) -> ()) {
        
        usersRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func getProfile(by userId: String? = nil, completion: @escaping (Result<RNBUser, Error>) -> ()) {
        
        usersRef.document(userId != nil ? userId! : AuthService.shared.currentUser!.uid).getDocument { docSnapShot, error in
            
            guard let snap = docSnapShot else { return }
            guard let data = snap.data() else { return }
            guard let userName = data["name"] as? String  else { return }
            guard let id = data["id"] as? String else { return }
            guard let phone = data["phone"] as? Int else { return }
            guard let address = data["address"] as? String else { return }
            
            let user = RNBUser(id: id, name: userName, phone: phone, address: address)
            
            completion(.success(user))
            
        }
    }
    
    func setProduct(product: Product, image: Data, completion: @escaping (Result<Product, Error>) -> ()) {
        
        StorageService.shared.upload(id: product.id, image: image) { result in
            switch result {
            case .success(let sizeInfo):
                print(sizeInfo)
                self.productsRef.document(product.id).setData(product.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(product))
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getProducts(completion: @escaping (Result<[Product], Error>) -> ()) {
        self.productsRef.getDocuments { qSnap, error in
            guard let qSnap = qSnap else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            let docs = qSnap.documents

           var products = [Product]()
            for doc in docs {
                guard let  product = Product(doc: doc) else { return }
                products.append(product)
            }
            
            completion(.success(products))
        }
    }
}
