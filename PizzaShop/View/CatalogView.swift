//
//  Catalog.swift
//  PizzaShop
//
//  Created by Никита Тюрин on 29.03.24.
//

import SwiftUI

struct CatalogView: View {
    
    let layoutForPopular = [GridItem(.adaptive(minimum: screen.width / 2.4))]
    let layoutForPizza = [GridItem(.adaptive(minimum: screen.width / 2.2))]
    @StateObject var viewModel = CatalogViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Section("Popular") {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layoutForPopular, spacing: 16) {
                        ForEach(CatalogViewModel.shared.popularProducts, id: \.id) { item in
                            NavigationLink {
                                
                                let viewModel = ProductDetailViewModel(product: item)
                                
                                ProductDetailView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }
                        }
                    }.padding()
                }
            }
            
            Section("Pizza") {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layoutForPizza, spacing: 16) {
                        ForEach(viewModel.pizzaProducts, id: \.id) { item in
                            NavigationLink {
                                
                                let viewModel = ProductDetailViewModel(product: item)
                                
                                ProductDetailView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }
                        }
                    }.padding()
                }
            }.navigationTitle(Text("Catalog"))
                .onAppear() {
                    self.viewModel.getProducts()
                }
        }
    }
    
    struct Catalog_Previews: PreviewProvider {
        static var previews: some View {
            CatalogView()
        }
    }
}
