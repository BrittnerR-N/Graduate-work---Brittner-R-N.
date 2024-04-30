//
//  PositionCell.swift
//  PizzaShop
//
//  Created by Никита Тюрин on 15.04.24.
//

import SwiftUI

struct PositionCell: View {
    
    let position: Position
    var body: some View {
        HStack {
            Text(position.product.title)
                .fontWeight(.bold)
            Spacer()
            Text("\(position.count) point")
            Text("\(position.cost) $")
                .frame(width: 100, alignment: .trailing)
        }.padding(.horizontal)
    }
}

struct PositionCell_Previews: PreviewProvider {
    static var previews: some View {
        PositionCell(
            position: Position(id: UUID().uuidString,
                product: Product(id: UUID().uuidString,
                    title: "Margarita",
                    imageUrl: "pizzaPH",
                    price: 350,
                    descript: "ttttttt"),
                    count: 3)
        )
    }
}
