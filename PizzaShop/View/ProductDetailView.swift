//
//  ProductDetailView.swift
//  PizzaShop
//
//  Created by Никита Тюрин on 30.03.24.
//

import SwiftUI

struct ProductDetailView: View {
        
    var viewModel: ProductDetailViewModel
    
    @State var size = "Little"
    @State var count = 1
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading) {
                
                Image("pizzaPH")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 260)
                HStack {
                    Text("\(viewModel.product.title)!")
                        .font(.title2.bold())
                    Spacer()
                    Text("\(viewModel.getPrice(size: size)) $")
                        .font(.title2)
                }.padding(.horizontal)
                
                Text("\(viewModel.product.descript)")
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                
                HStack {
                    Stepper("Количество", value: $count, in: 1...10)
                    
                    
                    Text("\(self.count)")
                        .padding(.leading, 25)
                }.padding(.horizontal)
                
                
                Picker("Size of pizza", selection: $size) {
                    ForEach(viewModel.sizes, id: \.self) { item in
                        Text(item)
                    }
                }.pickerStyle(.segmented)
                    .padding()
            }
            
            Button {
                var position = Position(id: UUID().uuidString,
                                        product: viewModel.product,
                                        count: self.count)
                position.product.price = viewModel.getPrice(size: size)
                
                CartViewModel.shared.addPosition(position)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Add to trash")
                    .padding()
                    .padding(.horizontal, 60)
                    .foregroundColor(Color("darkBrown"))
                    .font(.title3.bold())
                    .background(LinearGradient(colors: [Color("yellow"), Color("orange")], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(30)
            }
            Spacer()
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(viewModel: ProductDetailViewModel(product: Product(
                id: "1",
                title: "Margarita",
                imageUrl: "Not Found",
                price: 600,
                descript: "XXXXxxXX"
        )))
    }
}
